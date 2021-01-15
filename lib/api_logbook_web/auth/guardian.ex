defmodule ApiLogbookWeb.Auth.Guardian do
  use Guardian, otp_app: :api_logbook

  alias ApiLogbook.Accounts

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = Accounts.get_user! id
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  def authenticate(email, virt_password) do
    with {:ok, user} <- Accounts.get_by_email(email) do
      case validate_password(virt_password, user.password) do
        true -> create_token(user)
        false -> {:error, :unauthorized}
      end
    end
  end

  defp validate_password(virt_password, password) do
    Bcrypt.verify_pass(virt_password, password)
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
end

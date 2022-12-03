defmodule CodeCitadel.Repo do
  use Ecto.Repo,
    otp_app: :course_work,
    adapter: Ecto.Adapters.Postgres
end

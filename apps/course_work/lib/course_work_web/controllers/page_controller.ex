defmodule CodeCitadel.CouserWorkWeb.PageController do
  use CodeCitadel.CouserWorkWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

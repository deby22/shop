defmodule ShopWeb.FallbackController do
  @moduledoc false
  use ShopWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ShopWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end

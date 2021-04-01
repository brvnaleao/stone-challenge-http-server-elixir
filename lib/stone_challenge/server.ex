defmodule StoneChallenge.Server do
  @moduledoc """
  Example server for HTTP processing.
  """

  use Plug.Router

  alias StoneChallenge.BusinessLogic

  plug :match
  plug :dispatch

  get "/:items/:email" do

    %{"items" => items, "email" => email} = conn.path_params

    try do
      result = BusinessLogic.init(items, email)
      send_resp(conn, 200, result)

    catch
      e -> send_resp(conn, 400, e)
    end

  end

  match _ do
    send_resp(conn, 404, "oops")
  end


end

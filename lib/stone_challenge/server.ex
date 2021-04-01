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
    result = BusinessLogic.init(items, email)
    send_resp(conn, 200, result)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end


end

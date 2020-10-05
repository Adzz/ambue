defmodule AmbueWeb.PageLiveTest do
  use AmbueWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "<input type=\"text\" name=\"user_name\""
    assert render(page_live) =~ "<input type=\"text\" name=\"user_name\""
  end
end

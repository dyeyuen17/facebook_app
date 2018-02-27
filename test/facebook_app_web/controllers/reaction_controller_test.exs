defmodule FacebookAppWeb.ReactionControllerTest do
  use FacebookAppWeb.ConnCase

  alias FacebookApp.Actions
  alias FacebookApp.Actions.Reaction

  @create_attrs %{reaction: "some reaction"}
  @update_attrs %{reaction: "some updated reaction"}
  @invalid_attrs %{reaction: nil}

  def fixture(:reaction) do
    {:ok, reaction} = Actions.create_reaction(@create_attrs)
    reaction
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all reactions", %{conn: conn} do
      conn = get conn, reaction_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create reaction" do
    test "renders reaction when data is valid", %{conn: conn} do
      conn = post conn, reaction_path(conn, :create), reaction: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, reaction_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "reaction" => "some reaction"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, reaction_path(conn, :create), reaction: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update reaction" do
    setup [:create_reaction]

    test "renders reaction when data is valid", %{conn: conn, reaction: %Reaction{id: id} = reaction} do
      conn = put conn, reaction_path(conn, :update, reaction), reaction: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, reaction_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "reaction" => "some updated reaction"}
    end

    test "renders errors when data is invalid", %{conn: conn, reaction: reaction} do
      conn = put conn, reaction_path(conn, :update, reaction), reaction: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete reaction" do
    setup [:create_reaction]

    test "deletes chosen reaction", %{conn: conn, reaction: reaction} do
      conn = delete conn, reaction_path(conn, :delete, reaction)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, reaction_path(conn, :show, reaction)
      end
    end
  end

  defp create_reaction(_) do
    reaction = fixture(:reaction)
    {:ok, reaction: reaction}
  end
end

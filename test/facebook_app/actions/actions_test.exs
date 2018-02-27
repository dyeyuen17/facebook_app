defmodule FacebookApp.ActionsTest do
  use FacebookApp.DataCase

  alias FacebookApp.Actions

  describe "posts" do
    alias FacebookApp.Actions.Post

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Actions.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Actions.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Actions.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Actions.create_post(@valid_attrs)
      assert post.content == "some content"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Actions.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Actions.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.content == "some updated content"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Actions.update_post(post, @invalid_attrs)
      assert post == Actions.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Actions.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Actions.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Actions.change_post(post)
    end
  end

  describe "comments" do
    alias FacebookApp.Actions.Comment

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Actions.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Actions.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Actions.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Actions.create_comment(@valid_attrs)
      assert comment.content == "some content"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Actions.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, comment} = Actions.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.content == "some updated content"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Actions.update_comment(comment, @invalid_attrs)
      assert comment == Actions.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Actions.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Actions.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Actions.change_comment(comment)
    end
  end

  describe "reactions" do
    alias FacebookApp.Actions.Reaction

    @valid_attrs %{reaction: "some reaction"}
    @update_attrs %{reaction: "some updated reaction"}
    @invalid_attrs %{reaction: nil}

    def reaction_fixture(attrs \\ %{}) do
      {:ok, reaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Actions.create_reaction()

      reaction
    end

    test "list_reactions/0 returns all reactions" do
      reaction = reaction_fixture()
      assert Actions.list_reactions() == [reaction]
    end

    test "get_reaction!/1 returns the reaction with given id" do
      reaction = reaction_fixture()
      assert Actions.get_reaction!(reaction.id) == reaction
    end

    test "create_reaction/1 with valid data creates a reaction" do
      assert {:ok, %Reaction{} = reaction} = Actions.create_reaction(@valid_attrs)
      assert reaction.reaction == "some reaction"
    end

    test "create_reaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Actions.create_reaction(@invalid_attrs)
    end

    test "update_reaction/2 with valid data updates the reaction" do
      reaction = reaction_fixture()
      assert {:ok, reaction} = Actions.update_reaction(reaction, @update_attrs)
      assert %Reaction{} = reaction
      assert reaction.reaction == "some updated reaction"
    end

    test "update_reaction/2 with invalid data returns error changeset" do
      reaction = reaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Actions.update_reaction(reaction, @invalid_attrs)
      assert reaction == Actions.get_reaction!(reaction.id)
    end

    test "delete_reaction/1 deletes the reaction" do
      reaction = reaction_fixture()
      assert {:ok, %Reaction{}} = Actions.delete_reaction(reaction)
      assert_raise Ecto.NoResultsError, fn -> Actions.get_reaction!(reaction.id) end
    end

    test "change_reaction/1 returns a reaction changeset" do
      reaction = reaction_fixture()
      assert %Ecto.Changeset{} = Actions.change_reaction(reaction)
    end
  end
end

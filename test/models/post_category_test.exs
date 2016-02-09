defmodule KrishedgesSpace.PostCategoryTest do
  use KrishedgesSpace.ModelCase

  alias KrishedgesSpace.PostCategory

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostCategory.changeset(%PostCategory{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostCategory.changeset(%PostCategory{}, @invalid_attrs)
    refute changeset.valid?
  end
end

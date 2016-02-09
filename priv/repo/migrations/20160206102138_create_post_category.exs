defmodule KrishedgesSpace.Repo.Migrations.CreatePostCategory do
  use Ecto.Migration

  def change do
    create table(:post_categories) do
      add :post_id, references(:posts)
      add :category_id, references(:categories)

      timestamps
    end
    create index(:post_categories, [:post_id])
    create index(:post_categories, [:category_id])

  end
end

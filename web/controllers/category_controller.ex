defmodule KrishedgesSpace.CategoryController do
  use KrishedgesSpace.Web, :controller
  use Guardian.Phoenix.Controller
  alias KrishedgesSpace.Category

  plug :scrub_params, "category" when action in [:create, :update]
  plug Guardian.Plug.EnsureAuthenticated, %{ handler: { KrishedgesSpace.SessionController, :unauthenticated } } # when not action in [:index, :create]

  def index(conn, _params, current_user, claims) do
    categories = Repo.all(Category)
    render(conn, "index.json", categories: categories)
  end

  def create(conn, %{"category" => category_params}, current_user, claims) do
    changeset = Category.changeset(%Category{}, category_params)

    case Repo.insert(changeset) do
      {:ok, category} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", category_path(conn, :show, category))
        |> render("show.json", category: category)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KrishedgesSpace.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    category = Repo.get!(Category, id)
    render(conn, "show.json", category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}, current_user, claims) do
    category = Repo.get!(Category, id)
    changeset = Category.changeset(category, category_params)

    case Repo.update(changeset) do
      {:ok, category} ->
        render(conn, "show.json", category: category)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KrishedgesSpace.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user, claims) do
    category = Repo.get!(Category, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(category)

    send_resp(conn, :no_content, "")
  end
end

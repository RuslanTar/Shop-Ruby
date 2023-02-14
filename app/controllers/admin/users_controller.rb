module Admin
  class UsersController < HomeController
    # include ProductSearchable
    # include Users

    def index
      @all_users = User.all.order(id: :desc)
    end

    def new; end

    def show; end

    def edit; end

    def search
      @users = User.search(params[:query]) if params[:query].present?
    end

    def filter
      @users = User.filter(params[:role], params[:sort_by])
      render :'admin/users/search'
    end
  end
end

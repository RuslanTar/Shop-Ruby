module Admin
  class UsersController < HomeController
    include Users

    def index
      @users = User.all
    end

    def new; end

    def show; end

    def edit; end
  end
end

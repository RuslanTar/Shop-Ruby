module Admin
  class HomeController < ApplicationController
    before_action :check_admin_rights

    def index
      redirect_to :admin_dashboard
    end

    def dashboard; end

    private

    def check_admin_rights
      head(403) unless current_user.admin?
    end
  end

end
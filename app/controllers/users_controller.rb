
# frozen_string_literal: true

class UsersController < ApplicationController
  # include ProductSearchable

  before_action :set_user, only: %i[update destroy]

  # def index
  #   @all_users = User.all.order(:id)
  # end
  #
  # def show; end
  #
  # def new; end

  def create
    @user = User.create!(user_params)
    # render 'admin/products/new', status: :unprocessable_entity
    # render @product.errors.full_messages unless @product.valid?
    # flash[:error] = @product.errors.full_messages unless @product.save!
  end

  def update
    # debugger
    @user.update(user_params) # unless user_params[:role].include?('admin') && @user == current_user
  end

  def destroy
    flash[:error] = @user.errors.full_messages unless @user.destroy
  end

  def search
    @results = User.search(params[:query]) if params[:query].present?
  end

  def filter
    @results = User.filter(params[:query]) if params[:query].present?
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def set_user
    @user = User.find(params[:id]) if params[:id] != 'sign_out'
  end
end

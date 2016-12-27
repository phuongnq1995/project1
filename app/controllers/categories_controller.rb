class CategoriesController < ApplicationController
  before_action :admin_user, only: [:create, :edit, :update, :destroy]
  before_action :logged_in_user, only: :index

  def index
    @categories = Category.paginate(page: params[:page])
    @category = Category.new
    @lesson = Lesson.new
  end

  def show
    @category = Category.find(params[:id])
    @words = @category.words.paginate(page: params[:page])
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Create success !"
      redirect_to category_path(@category)
    else
      render 'index'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Profile updated !"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category deleted !"
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :discription)
  end
    # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end

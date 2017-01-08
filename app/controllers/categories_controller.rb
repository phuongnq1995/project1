class CategoriesController < ApplicationController
  before_action :admin_user, only: [:create, :edit, :update, :destroy]
  before_action :logged_in_user, only: :index
  before_action :load_category, only: [:edit, :update, :show, :destroy]

  def index
    @categories = Category.paginate page: params[:page],
      per_page: 5
    @category = Category.new
    @lesson = Lesson.new
  end

  def show
    @words = @category.words.paginate(page: params[:page])
    @word = @category.words.build
    4.times {@word.answers.build}
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
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = "Category updated !"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
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

  def load_category
    @category = Category.find(params[:id])
    unless @category
      flash[:danger] = "Can't load category"
      redirect_to categories_path
    end
  end
end

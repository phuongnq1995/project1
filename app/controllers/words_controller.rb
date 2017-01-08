class WordsController < ApplicationController
  before_action :admin_user, only: [:create, :edit, :update, :destroy]
  before_action :logged_in_user, only: :index
  before_action :load_category, only: :create

  def index
    @categories = Category.all
    condition = params[:condition].nil? ? "all" : params[:condition]
    @words = Word.send("by_#{condition}", current_user.id, category_id)
             .paginate page: params[:page]
  end

  def create
    @word = @category.words.build(word_params)
    if @word.save
      flash[:success] = "Create success !"
      redirect_to @category
    else
      flash[:danger] = "Create fail !"
      redirect_to @word.category
    end
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(word_params)
      flash[:success] = "Updated success !"
      redirect_to @word.category
    else
      flash[:danger] = "Updated fail !"
      render 'edit'
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    flash[:success] = "Word deleted !"
    redirect_to @word.category
  end

  private

  def word_params
    params.require(:word).permit(:content, answers_attributes: [:id, :content, :is_correct])
  end
  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def load_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "error_load"
      redirect_to categories_url
    end
  end
  def category_id
    params[:category_id].blank? ? @categories.map(&:id) : params[:category_id]
  end
end

class WordsController < ApplicationController
  before_action :admin_user, only: [:create, :edit, :update, :destroy]
  before_action :logged_in_user, only: :index

  def index
    @categories = Category.all
    condition = params[:condition].nil? ? "all" : params[:condition]
    @words = Word.send("by_#{condition}", current_user.id, category_id)
             .paginate page: params[:page]
  end

  def new
    @category = Category.find(params[:category_id])
    @word = @category.words.build
    4.times { @word.answers.build}
  end

  def show
    @category = Category.find(params[:category_id])
    @word = @category.words.find(params[:id])
  end

  def create
    @category = Category.find(params[:category_id])
    @word = @category.words.build(word_params)
    if @word.save
      flash[:success] = "Create success !"
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:category_id])
    @word = @category.words.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @word = @category.words.find(params[:id])
    if @word.update_attributes(word_params)
      flash[:success] = "Updated success !"
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @word = Word.find(params[:id])
    @word.destroy
    flash[:success] = "Word deleted !"
    redirect_to @category
  end

  private

  def word_params
    params.require(:word).permit(:content, answers_attributes: [:id, :content, :is_correct])
  end
    # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def category_id
    params[:category_id].blank? ? @categories.map(&:id) : params[:category_id]
  end

end

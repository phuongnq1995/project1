class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :load_lesson, only: [:edit, :update, :show]
  before_action :load_category, only: [:edit, :update, :create]

  def create
    @lesson = @category.lessons.build user: current_user
    if @lesson.save
      flash[:success] = "Started lesson"
      redirect_to edit_category_lesson_path(@category.id, @lesson)
    else
      flash[:danger] = "Fail message"
      redirect_to categories_path
    end
  end

  def edit
  end

  def update
    if @lesson.update_attributes(questions_params)
      flash[:success] = "Finish"
      redirect_to category_lesson_path(@lesson.category, @lesson)
    else
      render 'edit'
    end
  end

  def show
    @score = @lesson.questions.correct_anwsers.size
    @results = @lesson.questions.includes :word, :answer
  end

  private

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = "Can't load lesson !"
      redirect_to categories_path
    end
  end

  def load_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = "Can't load category"
      redirect_to categories_path
    end
  end

  def questions_params
    params.require(:lesson).permit :category_id,
      questions_attributes: [:id, :answer_id]
  end

end


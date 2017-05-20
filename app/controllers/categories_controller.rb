class CategoriesController < ApplicationController
  before_action :require_user, except: [:index, :show]

  def index
    @categories = Category.page(params[:page]).per(10)
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.page(params[:page]).per(10)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_user
    if !logged_in?
      flash[:danger] = "Only User can perform that action"
      redirect_to categories_path
    end
  end
end
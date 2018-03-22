class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except:[:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index
    @articles = Article.includes(:categories, :user).paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

def find
  if(params[:cat_id])
  #  @articles = Category.find(params[:cat_id]).articles.includes(:user,:categories).where(user_id: params[:user_id])
    @articles = Article.joins(:article_categories).includes(:user,:categories).where("user_id = ? AND article_categories.category_id = ?", params[:user_id], params[:cat_id])
    #@articles = Article.includes(:article_categories, :categories, :user).where(:article_categories => {category_id: params[:cat_id]} , user_id: params[:user_id])
  end
end

def temp
  @articles = Article.joins(:categories).where(user_id: params[:user_id] , category_id: params[:cat_id]).paginate(page: params[:page], per_page: 5)
end

def edit

end

def create
#  render plain: params[:article].inspect
  @article = Article.new(article_params)
  @article.user = current_user
  if @article.save
    flash[:success] = "Article is created successfully!"
    redirect_to article_path(@article)
  else
    render 'new'
  end
end

def update

  if @article.update(article_params)
    flash[:success] = "Article is successfully updated"
    redirect_to article_path(@article)
  else
    render 'edit'
  end
end

def show

end

def destroy
  @article.destroy
  flash[:danger] = "Article is destroyed"
  redirect_to articles_path
end

private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:danger] = "You can only edit your own articles"
      redirect_to root_path
    end
  end

end

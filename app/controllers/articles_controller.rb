class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user, except: [ :index, :show ]
  before_action :require_same_user, only: [ :edit, :update, :destroy ]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated"
      redirect_to @article
    else
      render "edit"
    end
  end

  def edit
  end

  def create
    # aici o fost ceva erroare ca gen nu ma ducea la un url daca l-am scris de mana doar daca i-am dat paste de pe git-u lui
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created succesfully"# un helper care e cam ca un hash views/layouts/application
      redirect_to @article
    else
      render :new, status: :unprocessable_entity# .html.erb
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end
end

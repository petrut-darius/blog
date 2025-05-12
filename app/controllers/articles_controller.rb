class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # aici o fost ceva erroare ca gen nu ma ducea la un url daca l-am scris de mana doar daca i-am dat paste de pe git-u lui
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice] = "Article was created succesfully"# un helper care e cam ca un has views/layouts/application
      redirect_to @article
    else
      render :new, status: :unprocessable_entity# .html.erb
    end
  end
end

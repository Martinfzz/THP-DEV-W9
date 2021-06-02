class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /articles or /articles.json
  def index
    @articles = Article.where(user_id: current_user) + Article.where(private: false)
    render json: @articles
  end

  # GET /articles/1 or /articles/1.json
  def show
    @articles = Article.find(params[:id])
    render json: @articles
  end

  # GET /articles/new
  def new
    @article = Article.new
    @user = helpers.current_user
  end

  # GET /articles/1/edit
  def edit
    @user = helpers.current_user
  end

  # POST /articles or /articles.json
  def create
    @article = Article.create(title: params[:title], content: params[:content], private: params[:private], user_id: current_user.id)
    render json: @article
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    if set_user
      @article = Article.find(params[:id])
      @article.update(title: params[:title], content: params[:content], private: params[:private], user_id: current_user.id)
      render json: @article
    else
      render json: { message: "You do not own this article"}
    end
    
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    if set_user
      @article = Article.find(params[:id])
      @article.destroy
      @articles = Article.where(user_id: current_user.id) + Article.where(private: false)
      render json: @articles
    else
      render json: { message: "You do not own this article"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :private)
    end

    def set_user
      current_user.id == Article.find(params[:id]).user_id
    end
end

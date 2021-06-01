class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
    @user = helpers.current_user
    render json: @articles
  end

  # GET /articles/1 or /articles/1.json
  def show
    @articles = Article.all
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
    @article = Article.create(article_params)
    render json: @article
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    if set_user
      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to @article, notice: "Article was successfully updated." }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    if set_user
      @article.destroy
      respond_to do |format|
        format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :user_id, :private)
    end

    def set_user
      current_user.id == Article.find(params[:id]).user_id
    end
end

class Api::UsersController < Api::BaseController

  before_action :find_article, only: %w[show, index]

  def index
    render_jsonapi_response(@article)
  end

  def show
    render_jsonapi_response(@article)
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

end
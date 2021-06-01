class Api::UsersController < Api::BaseController

  before_action :find_user, only: %w[show, index]
  
  def index
    render_jsonapi_response(@user)
  end

  def show
    @users = User.all
    render_jsonapi_response(@users)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
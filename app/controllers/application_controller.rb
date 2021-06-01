class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  def render_jsonapi_response(resource)
    
      render json: resource
    
     
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

end

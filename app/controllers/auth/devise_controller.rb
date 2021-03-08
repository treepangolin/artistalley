class Auth::DeviseController < ApplicationController
  class Responder < ActionController::Responder
    def to_turbo_stream
      controller.render(options.merge(formats: :html))
    rescue ActionView::MissingTemplate => e
      if get?
        raise e
      elsif has_errors? && default_action
        render rendering_options.merge(formats: :html, status: :unprocessable_entity)
      else
        begin
          redirect_to navigation_location
        rescue NoMethodError
          redirect_to :new_user_session
        end
      end
    end
  end

  self.responder = Responder
  respond_to :html, :turbo_stream
end

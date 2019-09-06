class BaseController < ApplicationController
  before_action :require_user, except: [:new, :create]

  def require_user
    render file: "/public/404" unless current_user?
  end
end

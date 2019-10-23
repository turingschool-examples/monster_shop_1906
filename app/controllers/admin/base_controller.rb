class Admin::BaseController<ApplicationController
  before_action :require_site_admin

  def require_site_admin
    render file: '/public/404' unless site_admin?
  end
end

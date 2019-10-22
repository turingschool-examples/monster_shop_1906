class Admin::DashboardController < Admin::BaseController
  def show
  end

  def index
    @users = User.all
  end
end

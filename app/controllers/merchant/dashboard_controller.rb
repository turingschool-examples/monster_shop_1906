class DashboardController < ApplicationController
  # require :merchant

  def show
    @user = User.find(params[:id])
  end

end

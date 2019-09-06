class Merchant::DashboardController < ApplicationController
  # require :merchant

  def show
    @user = current_user
  end

end

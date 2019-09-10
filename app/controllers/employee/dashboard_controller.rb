class Employee::DashboardController < ApplicationController
  def show
    @user = current_user
    if @user.role == 1 || 2
      @merchant = Merchant.find(@user.merchant_id)
    end
  end


  # private
  #
  # def merchant_params
  #   params.require(:user).permit(:merchant_id)
  # end

end

class Merchant::BaseController < ApplicationController
  before_action :require_merchant_user

  def require_merchant_user
    render file: "/public/404" unless (current_merchant_admin? || current_merchant_employee?)
  end

  # def require_merchant_admin
  #   render file: "/public/404" unless current_merchant_admin?
  # end
  #
  # def require_merchant_employee
  #   render file: "/public/404" unless current_merchant_employee?
  # end
end

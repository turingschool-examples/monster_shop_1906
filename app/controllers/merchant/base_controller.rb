class Merchant::BaseController < ApplicationController
  before_action :require_merchant

  def require_merchant
    render file: '/public/404' unless merchant_admin? || merchant_employee?
  end
end

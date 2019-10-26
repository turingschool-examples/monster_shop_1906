require 'rails_helper'

describe MerchantUser, type: :model do
  describe "validations" do
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :user_id }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should belong_to :user}
  end
end

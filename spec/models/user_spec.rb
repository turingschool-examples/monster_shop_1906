require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :e_mail }
    it { should validate_uniqueness_of :e_mail }
    it { should validate_presence_of :password }
  end
end

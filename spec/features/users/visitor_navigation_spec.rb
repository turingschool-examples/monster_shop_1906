# User Story 6, Visitor Navigation Restrictions
#
# As a Visitor
# When I try to access any path that begins with the following, then I see a 404 error:
# - '/merchant'
# - '/admin'
# - '/profile'

require 'rails_helper'

RSpec.describe 'Visitor Navigation' do
  describe 'As a visitor' do
    it 'when i try to go to /merchant or /profile or /admin i see 404 error' do

      # visit '/profile'
      # expect(page).to have_content("404")
    end
  end
end

require 'rails_helper'
require 'cancan/matchers'

describe UserAbility do

  describe 'with a admin user' do
    subject(:ability) { UserAbility.new(admin_user) }
    let!(:admin_user) { create(:director) }

  end
end


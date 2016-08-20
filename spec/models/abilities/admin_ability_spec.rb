require 'rails_helper'
require 'cancan/matchers'

def validate_admin_actions
  it { should be_able_to(:update,  CheckIn) }
  it { should be_able_to(:verify,  CheckIn) }
  it { should be_able_to(:destroy, CheckIn) }

  it { should be_able_to(:create,  School) }
  it { should be_able_to(:update,  School) }
  it { should be_able_to(:destroy, School) }

  it { should be_able_to(:export,  Semester) }

  it { should be_able_to(:update,  UserSemester) }

  it { should be_able_to(:create,  User) }
  it { should be_able_to(:verify,  User) }
  it { should be_able_to(:promote, User) }
  it { should be_able_to(:status,  User) }
end

describe AdminAbility do

  describe 'with a admin user' do
    subject(:ability) { AdminAbility.new(admin_user) }
    let!(:admin_user) { create(:director) }

    validate_admin_actions

    it { should_not be_able_to(:create,  Semester) }
    it { should be_able_to(:export,      Semester) }
    it { should_not be_able_to(:finish,  Semester) }
    it { should_not be_able_to(:pause,   Semester) }
  end

  describe 'with a president user' do
    subject(:ability) { AdminAbility.new(president_user) }
    let!(:president_user) { create(:president) }

    validate_admin_actions

    it { should be_able_to(:create,  Semester) }
    it { should be_able_to(:export,  Semester) }
    it { should be_able_to(:finish,  Semester) }
    it { should be_able_to(:pause,   Semester) }
  end
end


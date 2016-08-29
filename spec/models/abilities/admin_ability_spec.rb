require 'rails_helper'
require 'cancan/matchers'

def validate_admin_actions
  it { should be_able_to(:create,  Announcement.new) }
  it { should be_able_to(:update,  Announcement.new) }
  it { should be_able_to(:destroy, Announcement.new) }

  it { should be_able_to(:update,  CheckIn.new) }
  it { should be_able_to(:verify,  CheckIn.new) }
  it { should be_able_to(:destroy, CheckIn.new) }

  it { should be_able_to(:create,  School.new) }
  it { should be_able_to(:update,  School.new) }
  it { should be_able_to(:destroy, School.new) }

  it { should be_able_to(:export,  Semester.new) }

  it { should be_able_to(:update,  UserSemester.new) }

  it { should be_able_to(:create,  User.new) }
  it { should be_able_to(:verify,  User.new) }
  it { should be_able_to(:promote, User.new) }
  it { should be_able_to(:status,  User.new) }
end

describe AdminAbility do

  describe 'with a admin user' do
    subject(:ability) { AdminAbility.new(admin_user) }
    let!(:admin_user) { create(:director) }

    validate_admin_actions

    it { should_not be_able_to(:create,  Semester.new) }
    it { should be_able_to(:export,      Semester.new) }
    it { should_not be_able_to(:finish,  Semester.new) }
    it { should_not be_able_to(:pause,   Semester.new) }
  end

  describe 'with a president user' do
    subject(:ability) { AdminAbility.new(president_user) }
    let!(:president_user) { create(:president) }

    validate_admin_actions

    it { should be_able_to(:create,  Semester.new) }
    it { should be_able_to(:export,  Semester.new) }
    it { should be_able_to(:finish,  Semester.new) }
    it { should be_able_to(:pause,   Semester.new) }
  end
end


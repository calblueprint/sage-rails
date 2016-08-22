require 'rails_helper'
require 'cancan/matchers'

describe UserAbility do

  describe 'with a regular user' do
    subject(:ability) { UserAbility.new(user) }
    let!(:user_semester) { create(:user_semester, user: user) }
    let!(:user) { create(:user) }


    it { should_not be_able_to(:index,    User.new) }
    it { should_not be_able_to(:show,     User.new) }
    it { should_not be_able_to(:create,   User.new) }
    it { should_not be_able_to(:update,   User.new) }
    it { should_not be_able_to(:state,    User.new) }
    it { should_not be_able_to(:reset,    User.new) }
    it { should_not be_able_to(:register, User.new) }

    it { should be_able_to(:index,    user) }
    it { should be_able_to(:show,     user) }
    it { should be_able_to(:create,   user) }
    it { should be_able_to(:update,   user) }
    it { should be_able_to(:state,    user) }
    it { should be_able_to(:reset,    user) }
    it { should be_able_to(:register, user) }

    it { should_not be_able_to(:index,  UserSemester.new) }

    it { should be_able_to(:index,  user_semester) }

    it { should be_able_to(:index, Semester.new) }
    it { should be_able_to(:show,  Semester.new) }
    it { should be_able_to(:join,  Semester.new) }

    it { should be_able_to(:index, Announcement.new) }
    it { should be_able_to(:show,  Announcement.new) }

    it { should be_able_to(:index, School.new) }
    it { should be_able_to(:show,  School.new) }
  end
end


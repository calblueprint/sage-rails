require 'rails_helper'

describe SetActive do
  context 'with no semester' do
    it 'should not run' do
      expect(SetActive.new.send(:should_check_active?)).to be_falsey
    end
  end

  context 'with semester' do
    let!(:semester) { create(:semester, start: Time.now - 1.month, finish: nil) }

    context 'recently started' do
      let!(:semester) { create(:semester, start: Time.now, finish: nil) }

      it 'should not run' do
        expect(Semester.current_semester.first).to_not be_falsey
        expect(SetActive.new.send(:should_check_active?)).to be_falsey
      end
    end

    context 'with semester pauses' do
      it 'should return a > 2 week value' do
        travel_to Time.now

        semester.semester_pauses.create(date_paused: Time.now)
        expect(SetActive.new.send(:get_start_time)).to eq(Time.now - 3.weeks)

        semester.semester_pauses.create(date_paused: Time.now)
        expect(SetActive.new.send(:get_start_time)).to eq(Time.now - 4.weeks)
      end
    end

    context 'without semester pauses' do
      it 'should return a 2 week value' do
        travel_to Time.now

        expect(SetActive.new.send(:get_start_time)).to eq(Time.now - 2.weeks)
      end
    end

    context 'with checkins' do
      let!(:school) { create(:school) }
      let!(:user) { create(:user, school: school) }
      let!(:user_semester) { create(:user_semester, user: user, semester: semester) }

      it 'should be considered active if the check in was approved' do
        CheckIn.create school_id: school.id,
               user_id: user.id,
               semester_id: semester.id,
               start: Time.now - 1.hour,
               finish: Time.now,
               verified: true
        expect(SetActive.new.send(:has_check_in?, user)).to be_truthy
      end

      it 'should not be considered active if the check in was approved' do
        CheckIn.create school_id: school.id,
               user_id: user.id,
               semester_id: semester.id,
               start: Time.now - 1.hour,
               finish: Time.now,
               verified: false

        expect(SetActive.new.send(:has_check_in?, user)).to be_falsey
      end

      it 'should not be active if the check in was > 2 weeks ago && there weren\'t any pauses' do
        CheckIn.create school_id: school.id,
               user_id: user.id,
               semester_id: semester.id,
               created_at: Time.now - 3.weeks,
               start: Time.now - 3.weeks,
               finish: Time.now - 3.weeks + 1.hour,
               verified: true

        expect(SetActive.new.send(:has_check_in?, user)).to be_falsey
      end

      it 'should be active if the check in was > 2 weeks ago but there was a pause' do
        travel_to Time.now

        semester.semester_pauses.create(date_paused: Time.now)

        CheckIn.create school_id: school.id,
               user_id: user.id,
               semester_id: semester.id,
               created_at: Time.now - 3.weeks,
               start: Time.now - 3.weeks + 1.hour,
               finish: Time.now - 3.weeks + 2.hours,
               verified: true

        expect(SetActive.new.send(:has_check_in?, user)).to be_truthy
      end

      it 'should not be active if the check in was > 2 weeks ago & there was a pause, but unverified' do
        travel_to Time.now

        semester.semester_pauses.create(date_paused: Time.now)

        CheckIn.create school_id: school.id,
               user_id: user.id,
               semester_id: semester.id,
               created_at: Time.now - 3.weeks,
               start: Time.now - 3.weeks + 1.hour,
               finish: Time.now - 3.weeks + 2.hours,
               verified: false

        expect(SetActive.new.send(:has_check_in?, user)).to be_falsey
      end

      it 'should set student to inactive if they haven\'t had a valid checkin' do
        SetActive.new.perform
        updated_semester = UserSemester.find_by(semester_id: semester.id, user_id: user.id)
        expect(updated_semester).to be_truthy
        expect(updated_semester.status).to eq('inactive')
      end

      it 'should set student to active if they had a valid checkin' do
        CheckIn.create school_id: school.id,
               user_id: user.id,
               semester_id: semester.id,
               created_at: Time.now - 1.weeks,
               start: Time.now - 1.weeks + 1.hour,
               finish: Time.now - 1.weeks + 2.hours,
               verified: true

        user_semester.update_attribute(:status, UserSemester.statuses[:inactive])
        SetActive.new.perform

        updated_semester = UserSemester.find_by(semester_id: semester.id, user_id: user.id)
        expect(updated_semester).to be_truthy
        expect(updated_semester.status).to eq('active')
      end
    end
  end
end

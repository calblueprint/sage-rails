# == Schema Information
#
# Table name: semesters
#
#  id              :integer          not null, primary key
#  start           :datetime         not null
#  finish          :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  season          :integer
#  paused          :boolean          default(FALSE)
#  weeks_completed :integer          default(0)
#

require 'rails_helper'

describe Semester do
  describe 'should not be valid' do
    describe 'if there' do
      let!(:semester) do
        create :semester, start: Time.now - 1.week, finish: nil
      end

      let!(:invalid_semester) do
        build :semester, start: Time.now, finish: nil
      end

      it 'is a current semester' do
        expect(invalid_semester.valid?).to be false
      end
    end

    describe 'if there is no current_semester' do
      let!(:current_semester) do
        create :semester, start: Time.now - 1.week, finish: Time.now
      end

      let!(:invalid_semester) do
        build :semester, start: Time.now - 2.days, finish: nil
      end

      it 'but it overlaps' do
        expect(invalid_semester.valid?).to be false
      end
    end

    describe 'if finish' do
      let!(:semester) do
        create :semester, start: Time.now, finish: nil
      end

      it 'is before the start' do
        expect(semester.update_attributes({ finish: Time.now - 1.week })).to be false
      end
    end
  end

  describe 'should be valid' do
    describe "if it has" do
      let!(:semester) do
        build :semester, start: Time.now - 1.week, finish: nil
      end

      it "a valid start date" do
        expect(semester.valid?).to be true
      end

      it "a valid finish date" do
        semester.save
        expect(semester.update_attributes({ finish: Time.now })).to be true
      end
    end
  end
end

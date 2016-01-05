require 'rails_helper'

describe Semester do
  describe 'should not be valid' do
    describe 'if there is' do
      let!(:current_semester) do
        create :semester, start: Time.now - 1.week, finish: nil
      end

      let!(:invalid_semester) do
        build :semester, start: Time.now, finish: nil
      end

      it 'a current semester' do
        expect(invalid_semester.valid?).to be false
      end
    end

    describe 'if there is no current_semester' do
      let!(:current_semester) do
        create :semester, start: Time.now, finish: Time.now + 1.week
      end

      let!(:invalid_semester) do
        build :semester, start: Time.now, finish: nil
      end

      it 'but it overlaps' do
        expect(invalid_semester.valid?).to be false
      end
    end

    describe 'if finish' do
      let!(:invalid_semester) do
        create :semester, start: Time.now, finish: nil
      end

      it 'is before the start' do
        expect(invalid_semester.update_attributes({ finish: Time.now - 1.week })).to be false
      end
    end
  end
end

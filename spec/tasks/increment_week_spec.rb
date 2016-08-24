require 'rails_helper'

describe IncrementWeek do
  let(:increment_week) { IncrementWeek.new }

  context 'with no empty semester' do
    it 'should not run' do
      expect(Rails.logger).to receive(:info).with("Starting increment week job")
      expect(Rails.logger).to receive(:info).with("No current semester")
      expect(Rails.logger).to_not receive(:info).with("Semester paused, unpausing")

      increment_week.perform
    end
  end

  context 'with an active semester' do

    let!(:semester) { create(:semester, finish: nil, paused: false) }

    it 'should increment week if semester is not paused' do
      expect(Rails.logger).to receive(:info).with("Starting increment week job")
      expect(Rails.logger).to receive(:info).with("Finished increment week job")
      expect(Rails.logger).to receive(:info).with("Semester not paused, incrementing week")
      expect(Rails.logger).to_not receive(:info).with("Semester paused, unpausing")

      increment_week.perform

      expect(Semester.current_semester.first.weeks_completed).to eq(1)
    end

    it 'should not increment week if semester is paused' do
      expect(Rails.logger).to receive(:info).with("Starting increment week job")
      expect(Rails.logger).to receive(:info).with("Finished increment week job")
      expect(Rails.logger).to receive(:info).with("Semester paused, unpausing")
      expect(Rails.logger).to_not receive(:info).with("Semester not paused, incrementing week")

      semester.update_attribute(:paused, true)
      increment_week.perform

      expect(SemesterPause.count).to eq(2)
      expect(Semester.current_semester.first.paused).to be_falsey
    end
  end
end

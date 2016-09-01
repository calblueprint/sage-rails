require 'rails_helper'

describe FinishSemester do
  context 'with no valid semester' do
    let!(:semester) { create(:semester, start: Time.now, finish:nil) }

    it 'should not run if the semester isn\'t finished' do
    end
  end
end

require 'rails_helper'

describe SetActive do
  it 'should not run if there is no semester' do
    expect(SetActive.new.send(:should_check_active?)).to be_falsey
  end

  describe 'should run' do
    let!(:current_semester) { create }
  end
end

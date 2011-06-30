require 'spec_helper'

describe Mentor do
  it 'has a valid factory' do
    mentor = Factory.build(:mentor)
    mentor.should be_valid
  end

  context 'validations' do
    let(:mentor) { Factory(:mentor) }
    it 'does not require password again' do
      mentor.should be_valid
    end
    it 'does ignore password overwrite with nil' do
      mentor.password = mentor.password_confirmation = nil
      mentor.should be_valid
    end
    # devise triggers an error when empty passwords are entered. but this
    # is the default when submitting a form
    it 'does trigger an error on blank password' do
      mentor.password = mentor.password_confirmation = ''
      mentor.should be_valid
    end
    it 'does not allow nil password on unsaved mentor' do
      new_mentor = Factory.build(:mentor)
      new_mentor.password = new_mentor.password_confirmation = nil
      new_mentor.should_not be_valid
    end
  end

  it 'should calculate sum of all journal entries' do
    mentor = Factory(:mentor)
    Factory(:journal, :mentor => mentor, :start_at => '12:00', :end_at => '13:30')
    Factory(:journal, :mentor => mentor, :start_at => '14:00', :end_at => '14:30')
    mentor.total_work_duration.should eq(120)
  end

end

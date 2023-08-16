require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Wick', photo: 'someurl.com', bio: 'The BabaYaga', posts_counter: 0) }

  before { subject.save }

  it 'user should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post counter should not be negative' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end
end

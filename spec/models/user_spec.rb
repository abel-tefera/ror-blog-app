require 'rails_helper'

RSpec.describe User, type: :model do
  op { User.new(name: 'John Wick', photo: 'someurl.com', bio: 'The BabaYaga', posts_counter: 0) }

  before { op.save }

  it 'user should have a name' do
    op.name = nil
    expect(op).to_not be_valid
  end

  it 'post counter should not be negative' do
    op.posts_counter = -1
    expect(op).to_not be_valid
  end

end
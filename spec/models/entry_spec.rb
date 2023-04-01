require 'rails_helper'

RSpec.describe Entry, type: :model do
  before :each do
    @user = User.create(
      name: 'Eva',
      email: 'bucur.eva87@gmail.com',
      password: 'password'
    )

    @group = Group.create(
      name: 'Group 1',
      author_id: @user.id
    )

    @entry = Entry.create(
      name: 'A new transaction',
      amount: 12.22,
      groups: [@group],
      author: @user
    )
  end

  describe 'entry#Validations' do
    it 'should be validate with valid attributes' do
      expect(@entry).to be_valid
    end

    it 'should have a name attribute' do
      @entry.name = nil
      expect(subject).not_to be_valid
    end
  end
end

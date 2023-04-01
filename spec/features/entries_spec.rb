require 'rails_helper'

RSpec.describe 'Entries', type: :feature do
  describe 'GET /groups' do
    let(:user) do
      User.create!(
        name: 'user',
        email: 'user@example.com',
        password: 'password'
      )
    end

    context 'when user visits the groups page' do
      it 'displays the Create a new Group button' do
        allow_any_instance_of(GroupsController).to receive(:authenticate_user!).and_return(true)
        visit groups_path
        expect(page).to have_content('Create a new Group')
      end
    end
  end
end

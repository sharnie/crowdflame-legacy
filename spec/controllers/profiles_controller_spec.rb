require 'rails_helper'

describe ProfilesController do
  it 'get profile show' do
    # user = create(:user)
    # login_as(user, :scope => :user)
    # visit user_profile_path(attributes_for(:user)[:username])
    # expect(response.body).to match("#{attributes_for(:user)[:username]}")
  end

  it 'get 404 on profile not found' do
    get :show, id: "doesnotexist"
    expect(response.status).to eq(404)
  end
end
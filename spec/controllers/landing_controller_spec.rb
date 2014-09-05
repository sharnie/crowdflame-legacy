require 'rails_helper'

describe LandingController do
  describe "GET index" do
    it 'displays homepage' do
      visit root_url
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
    end
  end
end
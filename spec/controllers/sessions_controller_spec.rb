require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before { get :new }

  context "GET #new" do
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'returns new template' do
      expect(response).to render_template :new
    end
  end
end

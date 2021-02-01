require 'rails_helper'

RSpec.describe HelpController do
  describe 'GET index' do
    it "is successful" do
      # DO NO DO get '/help'

      get :index
    end
  end
end

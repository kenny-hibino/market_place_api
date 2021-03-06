require "rails_helper"

class Authentication
  include Authenticable

  def request
  end

  def response
  end
end

RSpec.describe Authenticable do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe "#current_user" do
    before do
      @user = FactoryGirl.create :user
      request.headers["Authorization"] = @user.auth_token
      allow(authentication).to receive(:request).and_return(request)
    end

    it "returns the user from the authorization header" do
      expect(authentication.current_user.auth_token).to eq(@user.auth_token)
    end
  end

  # TODO: re-examine what to test.
  #describe  "#authenticate_with_token!" do
  #  before do
  #    @user = FactoryGirl.create(:user)
  #    allow(authentication).to receive(:current_user).and_return(nil)
  #    allow(response).to receive(:response_code).and_return(401)
  #    allow(response).to receive(:body).and_return({ "errors" => "Not authenticated" }.to_json)
  #    allow(authentication).to receive(:response).and_return(response)
  #  end

  #  xit "renders JSON with a error message" do
  #    expect(json_response[:errors]).to eq("Not authenticated")
  #  end

  #  xit "responds with HTTP status 401" do
  #    expect(response.status).to eq(401)
  #  end
  #end
end

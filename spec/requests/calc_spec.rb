require 'rails_helper'

RSpec.describe "Calcs", type: :request do
  describe "GET /input" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /view" do
    it "returns http success" do
      get "/calc/view"
      expect(response).to have_http_status(:success)
    end

    it "returns correct result" do
      get "/calc/view.x?less_than_number=27&commit=Find+palindroms"
      expect(controller.instance_variable_get(:@result)).to eq([[1,1],[2,4],[3,9],[11,121],[22,484],[26,676]])
    end
    it "returns correct result" do
      get "/calc/view.x?less_than_number=150&commit=Find+palindroms"
      expect(controller.instance_variable_get(:@result)).to eq([[1,1],[2,4],[3,9],[11,121],[22,484],[26,676],[101,10201],[111,12321],[121,14641]])
    end
  end

end

require "rails_helper"

RSpec.describe "Search API" do
  xit "finds ones merchant by search" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/find?name=will"

    expect(response).to be_successful

    JSON.parse(response.body, symbolize_names: true)
    binding.pry
  end
  it "finds all items by search" do
    get "/api/v1/items/find_all"
  end
end

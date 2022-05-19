require "rails_helper"

RSpec.describe "Item API" do
  it "gets all items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)
    end
  end
  it "gets one item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_an(Float)
  end
  it "creates an item" do
    merchant = create(:merchant)
    item_params = {
      name: "Dark Repulser",
      description: "A cool sword",
      unit_price: 100,
      merchant_id: merchant.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
  end
  it "edits an item" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id
    previous_name = Item.last.name
    item_params = {name: "Elucidator"}
    headers = {"CONTENT_TYPE" => "application/json"}

    put "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Elucidator")
  end
  xit "cant edit fake merchant" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id

    item_params = {merchant_id: 28}
    headers = {"CONTENT_TYPE" => "application/json"}

    put "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

    expect(response).to be_successful
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
  it "deletes an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
  it "deletes an item" do
    item = create(:item)

    expect { delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_success
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
  it "gets merchant data for item" do
    merch = create(:merchant)
    item = create(:item, merchant_id: merch.id)

    get "/api/v1/items/#{item.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to eq(merch.id.to_s)
  end
end

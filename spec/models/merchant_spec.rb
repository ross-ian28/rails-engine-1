require "rails_helper"

RSpec.describe Merchant, type: :model do
  # describe "validations" do
  #   it { should validate_presence_of :name }
  #   it { should validate_presence_of :merchant_id }
  # end
  # describe "relationships" do
  #   it { should have_many :items }
  # end

  describe "class methods" do
    xit "#find_merch" do
      merchant1 = Merchant.create(name: "Pabu")
      merchant2 = Merchant.create(name: "Loki")
      merchant3 = Merchant.create(name: "Thor")

      expect(Merchant.find_merch("pabu")).to eq(merchant1.id)
    end
  end
end

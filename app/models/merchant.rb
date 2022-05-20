class Merchant < ApplicationRecord
  has_many :items

  def self.find_merch(search_name)
    where("name LIKE ?", search_name)
      .order(name)
      .first
  end
end

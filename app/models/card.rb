class Card < ApplicationRecord
  belongs_to :season

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["season", "series"]
  end
end

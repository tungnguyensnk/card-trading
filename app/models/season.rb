class Season < ApplicationRecord
  belongs_to :series

  has_many :cards, dependent: :destroy
end

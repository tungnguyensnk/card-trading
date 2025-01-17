class Series < ApplicationRecord
  has_many :seasons, dependent: :destroy
  has_many :cards, through: :seasons
end

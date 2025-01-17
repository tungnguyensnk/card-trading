class Admin::CardsController < ApplicationController
  require 'csv'

  def index
    @cards = Card.includes(season: :series).all.page(params[:page])
  end

  def upload
    if request.post?
      if params[:file].present?
        begin
          CSV.foreach(params[:file].path, headers: true) do |row|
            season = Season.find_or_create_by(name: row["season_name"]) do |s|
              series = Series.find_or_create_by(name: row["series_name"])
              s.series = series
              s.release_date = row["release_date"]
            end

            Card.create!(
              season: season,
              name: row["name"],
              rarity: row["rarity"],
              card_type: row["card_type"],
              description: row["description"],
              image_url: row["image_url"]
            )
          end
          redirect_to admin_cards_path, notice: "Cards uploaded successfully."
        rescue => e
          redirect_to admin_cards_path, alert: "Failed to upload CSV: #{e.message}"
        end
      else
        redirect_to admin_cards_path, alert: "Please select a CSV file."
      end
    end
  end
end

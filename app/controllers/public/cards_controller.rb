class Public::CardsController < ApplicationController
  before_action :set_var

  layout 'public/wrapper'

  def index
    if params[:series].present?
      @series = Series.find(params[:series])
      @cards = @q.result.where(season: { series_id: params[:series] })
    else
      @cards = @q.result
    end
  end

  def show
    @card = Card.find(params[:id])
    @prev_card = Card.where('id < ?', @card.id).order(id: :desc).first
    @next_card = Card.where('id > ?', @card.id).order(id: :asc).first
  end

  def set_var
    @series_list = Series.all
    @q = Card.includes(season: :series).ransack(params[:q])
    # quality: Near Mint, Lightly Played, Moderately Played, Heavily Played, Damaged
    # language: English, Japanese
    @sellers = [
      { name: "Hairy Tarantula", quality: "Near Mint", language: "English", quantity: 10, price: 10.14 },
      { name: "Red Dragon", quality: "Lightly Played", language: "English", quantity: 8, price: 6.14 },
      { name: "The End Games", quality: "Moderately Played", language: "Japanese", quantity: 10, price: 10.14 },
      { name: "401 Games", quality: "Heavily Played", language: "English", quantity: 4, price: 2.14 },
      { name: "Cardboard Memories", quality: "Damaged", language: "Japanese", quantity: 10, price: 10.14 },
      { name: "Hairy Tarantula", quality: "Near Mint", language: "English", quantity: 9, price: 9.14 },
      { name: "Red Dragon", quality: "Lightly Played", language: "English", quantity: 10, price: 10.14 },
      { name: "The End Games", quality: "Moderately Played", language: "Japanese", quantity: 2, price: 1.14 },
      { name: "401 Games", quality: "Heavily Played", language: "English", quantity: 10, price: 10.14 },
      { name: "Cardboard Memories", quality: "Damaged", language: "Japanese", quantity: 10, price: 10.14 },
      { name: "Hairy Tarantula", quality: "Near Mint", language: "English", quantity: 10, price: 10.14 },
      { name: "Red Dragon", quality: "Lightly Played", language: "English", quantity: 10, price: 10.14 },
      { name: "The End Games", quality: "Moderately Played", language: "Japanese", quantity: 10, price: 10.14 },
      { name: "401 Games", quality: "Heavily Played", language: "English", quantity: 10, price: 10.14 },
      { name: "Cardboard Memories", quality: "Damaged", language: "Japanese", quantity: 10, price: 10.14 },
    ]

    @quality_colors = {
      "Near Mint" => "success",
      "Lightly Played" => "info",
      "Moderately Played" => "warning",
      "Heavily Played" => "danger",
      "Damaged" => "dark"
    }

    @language_classes = {
      "English" => "fi-us",
      "Japanese" => "fi-jp"
    }
  end
end

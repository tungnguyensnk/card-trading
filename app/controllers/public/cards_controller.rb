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
  end
end

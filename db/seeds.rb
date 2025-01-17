Card.destroy_all
Season.destroy_all
Series.destroy_all

# read csv file and create records
require 'csv'
csv = CSV.read('db/data/cards1.csv', headers: true)
csv.each do |row|
  series = Series.find_or_create_by!(name: row['series_name'])
  season = Season.find_or_create_by!(series: series, name: row['season_name'], release_date: row['release_date'])
  Card.create!(season: season, name: row['name'], rarity: row['rarity'], card_type: row['card_type'], description: row['description'], image_url: row['image_url'])
  puts "Created card: #{row['name']}"
end

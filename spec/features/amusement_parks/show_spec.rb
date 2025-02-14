require 'rails_helper'

RSpec.describe 'Amusement Park Show Page' do
  before(:each) do
    @amusement_park_1 = AmusementPark.create!(name: 'Elitches', admission_cost: 30)
    @amusement_park_2 = AmusementPark.create!(name: 'Best Park', admission_cost: 75)

    @ride_1 = @amusement_park_1.rides.create!(name: 'Tower of Doom', thrill_rating: 10, open: true)
    @ride_2 = @amusement_park_1.rides.create!(name: 'Ding Dong Dock', thrill_rating: 2, open: true)
    @ride_3 = @amusement_park_1.rides.create!(name: 'Boomerang', thrill_rating: 7, open: true)
    @ride_4 = @amusement_park_1.rides.create!(name: 'Mind Eraser', thrill_rating: 8, open: false)
    @ride_5 = @amusement_park_2.rides.create!(name: 'Woo', thrill_rating: 4, open: true)

    visit amusement_park_path(@amusement_park_1.id)
  end

  scenario 'visitor sees name and price for that amusement park' do
    expect(page).to have_content(@amusement_park_1.name)
    expect(page).to have_content(@amusement_park_1.admission_cost)
  end

  scenario 'visitor sees names of all rides at the park in alphabetical order' do
    expect(@ride_3.name).to appear_before(@ride_2.name)
    expect(@ride_3.name).to appear_before(@ride_1.name)
    expect(@ride_3.name).to appear_before(@ride_4.name)
    expect(@ride_2.name).to appear_before(@ride_4.name)
    expect(@ride_2.name).to appear_before(@ride_1.name)
    expect(@ride_4.name).to appear_before(@ride_1.name)
    expect(@ride_1.name).to_not appear_before(@ride_4.name)
  end

  scenario 'visitor sees average thrill rating of park rides' do
    expect(page).to have_content("Average Thrill Rating of Rides: #{@amusement_park_1.rides.average_thrill}/10")
  end
end

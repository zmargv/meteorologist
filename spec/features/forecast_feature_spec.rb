require 'rails_helper'

RSpec.describe 'Forecast:', type: :feature do

  describe "coords to weather" do
    before do
      visit "/coords_to_weather/new"
      fill_in "Latitude", with: @lat
      fill_in "Longitude", with: @lng
      click_button "Lookup Weather"
    end

    context 'results page' do
      it "displays the latitude", points: 0 do
        expect(page).to have_content @lat
      end

      it "displays the longitude", points: 0 do
        expect(page).to have_content @lng
      end

      it "displays the current temperature", points: 5 do
        temp = '46'
        expect(page).to have_content(temp)
      end

      it "displays the current summary", points: 5 do
        outlook = 'Partly Cloudy'
        expect(page).to have_content(/#{outlook}/i)
      end

      it "displays the outlook for the next sixty minutes", points: 5 do
        outlook = 'Partly cloudy for the hour'
        expect(page).to have_content(/#{outlook}/i)
      end

      it "displays the outlook for the next several hours", points: 5 do
        outlook = 'Mixed precipitation starting tomorrow morning, continuing until tomorrow afternoon'
        expect(page).to have_content(/#{outlook}/i)
      end

      it "displays the outlook for the next several days", points: 5 do
        outlook = 'Light rain tomorrow through Saturday, with temperatures peaking at 69°F on Thursday'
        expect(page).to have_content(/#{outlook}/i)
      end
    end
  end
end

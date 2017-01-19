require 'rails_helper'

RSpec.describe 'Geocoding:', type: :feature do

  describe "street to coords" do
    before do
      visit "/street_to_coords/new"
      fill_in "Street Address", with: @address
      click_button "Lookup Coordinates"
    end

    context 'results page' do
      it "displays the street address", points: 0 do
        expect(page).to have_content(/#{@address}/i)
      end

      it "displays the latitude", points: 5 do
        expect(page).to have_content '38.89'
      end

      it "displays the longitude", points: 5 do
        expect(page).to have_content '-77.03'
      end
    end
  end
end

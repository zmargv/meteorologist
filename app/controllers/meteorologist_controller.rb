require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    url = url + @street_address.gsub(" ", '+')
    parsed = JSON.parse(open(url).read)
    
    @latitude = parsed["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed["results"][0]["geometry"]["location"]["lng"]
    
    url = "https://api.darksky.net/forecast/95249eb4306ac9f15e5ddac1e710c807/"
    url = url + @latitude.to_s + "," + @longitude.to_s
    #url = url + "41.78" + "," + "-87.59"
    parsed = JSON.parse(open(url).read)

    @current_temperature = parsed["currently"]["temperature"]

    @current_summary = parsed["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed.dig("minutely","summary")

    @summary_of_next_several_hours = parsed.dig("hourly","summary")

    @summary_of_next_several_days = parsed.dig("daily","summary")

    render("meteorologist/street_to_weather.html.erb")
  end
end

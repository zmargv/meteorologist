require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================
    
    url = "https://api.darksky.net/forecast/95249eb4306ac9f15e5ddac1e710c807/"
    url = url + @lat + "," + @lng
    parsed = JSON.parse(open(url).read)


    @current_temperature = parsed["currently"]["temperature"]

    @current_summary = parsed["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed.dig("minutely","summary")

    @summary_of_next_several_hours = parsed.dig("hourly","summary")

    @summary_of_next_several_days = parsed.dig("daily","summary")

    render("forecast/coords_to_weather.html.erb")
  end
end

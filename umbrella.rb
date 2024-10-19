
require "http"
require "json"
require "dotenv/load"

#ENV.fetch("GMAPS_KEY")
#ENV.fetch("OPENAI_KEY")

pp "What is your location?"
location = gets.chomp
#find lat & land from google map 
google_map_api_key = ENV.fetch("GMAPS_KEY")
# Assemble the full Google URL string by adding the first part, the API token, and the last part together
google_map_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + location + "&key=" + google_map_api_key

response = HTTP.get(google_map_url)

parsed_response = JSON.parse(response)

#pp parsed_response


latitude =  parsed_response.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat") 

longitude =  parsed_response.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng") 


# find weather
pirate_weather_api_key = ENV.fetch("WEATHER_KEY")

# Assemble the full URL string by adding the first part, the API token, and the last part together
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/" + latitude.to_s + "," + longitude.to_s

# Place a GET request to the URL
raw_response = HTTP.get(pirate_weather_url)


parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."

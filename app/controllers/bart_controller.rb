require 'Faraday'
require 'json'

class BartController < ApplicationController
  def home
  	stations
  end

  def stations
  	response = Faraday.get 'http://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V&json=y'
  	body = JSON.parse(response.body)
  	@stations = body['root']['stations']['station'].map do |s| 
  		{
  			name: s['name'],
  			abbr: s['abbr']
  		}
  	end.to_json
  end

  # [GET /trips?source=<STN_ABBR>&dest=<STN_ABBR>]
  def trips
  	src = params[:source]
  	dest = params[:dest]
  	response = Faraday.get "http://api.bart.gov/api/sched.aspx?cmd=depart&orig=#{src}&dest=#{dest}&date=now&key=MW9S-E7SL-26DU-VV8V&b=0&a=4&l=1&json=y"
  	body = JSON.parse(response.body)
  	@trips = body['root']['schedule']['request']['trip']
  	render json: @trips
  end

  # [GET /station?source=<STN_ABBR> ]
  def station
    src = params[:source]
  	response = Faraday.get "http://api.bart.gov/api/stn.aspx?cmd=stninfo&orig=#{src}&key=MW9S-E7SL-26DU-VV8V&json=y"
  	body = JSON.parse(response.body)
  	@station = body['root']['stations']['station']
  end	
end

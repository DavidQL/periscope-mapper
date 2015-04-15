require 'hydna'

class Broadcast
  include Mongoid::Document
  field :url, type: String
  field :location, type: String
  field :lat, type: BigDecimal
  field :lon, type: BigDecimal

  def self.notify_broadcast_added(location, coords, periscope_url)
    begin
      Hydna.push("periscopemapper.hydna.net", {
        location: location,
        coord: coords,
        periscope_url: periscope_url
      }.to_json)
    rescue Exception => e
      puts e.message
    end
  end
end




require 'pubnub'

class Broadcast
  include Mongoid::Document
  field :url, type: String
  field :location, type: String
  field :lat, type: BigDecimal
  field :lon, type: BigDecimal

  def self.notify_broadcast_added(location, coords, periscope_url)
    pubnub = Pubnub.new(
      :publish_key   => ENV['PUBNUB_PUBLISH_KEY'],
      :subscribe_key => ENV['PUBNUB_SUBSCRIBE_KEY']
    )
    pubnub.publish(
      :channel  => 'broadcast_added',
      :message => {
        location: location,
        coords: coords,
        periscope_url: periscope_url
      }.to_json,
    ) { |data| puts data.response }
  end
end
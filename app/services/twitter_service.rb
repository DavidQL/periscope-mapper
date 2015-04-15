require 'nokogiri'
require 'open-uri'

class TwitterService
  def self.start_polling
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end

    self.do_poll(client)
  end

  def self.do_poll(client)
    begin
      client.filter(track: "LIVE on #Periscope") do |object|
        begin
          periscope_url = "http://#{object.uris[0].expanded_url.host}#{object.uris[0].expanded_url.path}"
          doc = Nokogiri::HTML(open(periscope_url))

          location = doc.css('meta[name="description"]')[0].attributes["content"].value.split("from").last.strip!
          
          if location
            coords = Geocoder.coordinates(location)
            puts "#{location} (#{coords}): #{periscope_url}"
            self.save_broadcast(location, coords, periscope_url)
            Broadcast.notify_broadcast_added(location, coords, periscope_url)
          end            

        rescue Exception => e
          puts "exception inside tweet parsing"
        end   
      end
    rescue Twitter::Error::TooManyRequests
      puts 'exception: too many requests'
      self.do_poll(client)
    end
  end

  def self.save_broadcast(location, coords, url)
    Broadcast.create(location: location, url: url, lat: coords[0], lon: coords[1])
  end
end


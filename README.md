### Periscope Mapper

This application plots live Periscope broadcasts on a map. It does this by using the Twitter streaming API to collect tweets that advertise a live Periscope broadcast, and then plot those tweets on a Google map. 

Periscope does *not* expose their API, and the tweets advertising a Periscope broadcast are not geotagged. To get around this, I used Capybara to scrape a Periscope broadcast web page to capture the city and then geocoded that city with the Geocoder gem.

That data is then passed off to the browser client over web sockets. 

#### Requirements

* Ruby 2.1.0
* Mongo installed locally

#### API Keys

This app relies on a number of external services which require an API key to access. These API keys are *not* checked into this repo; you must get your own keys. The following API keys are required and must be available in the app's global environment (`ENV`):

CONSUMER_KEY (Twitter consumer key)
CONSUMER_SECRET (Twitter consumer secret)
ACCESS_TOKEN (Twitter access token)
ACCESS_TOKEN_SECRET (Twitter access token secret)
GOOGLE_API_KEY (Google API key to use Maps)
PUBNUB_PUBLISH_KEY (Pubnub key to publish message)
PUBNUB_SUBSCRIBE_KEY (Pubnub key to subscribe to message)

#### Setup

1. Clone this Rails app.
2. In the app directory, install gems: `bundle install`
3. Ensure you have your API keys populated (see above section, "API Keys")

#### Steps to run locally

1. Start MongoDB: `sudo mongod`
2. Start Rails: `rails s`
2. Start polling: (from within the app's Rails console, run): `TwitterService.start_polling`
3. Open the app in a browser: `http://localhost:3000
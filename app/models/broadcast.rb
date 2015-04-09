class Broadcast
  include Mongoid::Document
  field :url, type: String
  field :location, type: String
  field :lat, type: BigDecimal
  field :lon, type: BigDecimal
end
module Subscriber
  # delegate to ActiveSupport::Notifications.subscribe
  def self.subscribe(event_name)
    if block_given?
      binding.pry
      ActiveSupport::Notifications.subscribe(event_name) do |*args|
        event = ActiveSupport::Notifications::Event.new(*args)
        yield(event)
      end
    end
  end
end
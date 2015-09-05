class UpdateSubscriber
  attr_reader :destroy_existing, :traits, :subscriber_datum,
              :subscriber, :subscriber_attributes

  def initialize(params, destroy_existing: nil)
    @destroy_existing = destroy_existing
    @traits = params.fetch(:traits)
    @subscriber_attributes = params.reject {|k,_| k == 'traits' }
    subscriber_id = params.fetch(:subscriber_id)
    @subscriber_datum = SubscriberDatum
                          .find_or_initialize_by(subscriber_id: subscriber_id) 

    @subscriber = Subscriber.find(subscriber_id)
  end

  def perform
    Subscriber.transaction do
      if destroy_existing
        subscriber_datum.traits = traits 
      else
        subscriber_datum.traits.merge!(traits) 
      end
      
      subscriber_datum.save!
      subscriber.update!(subscriber_attributes)
    end
  end

  def self.with_existing(params)
    new(params, destroy_existing: false).perform   
  end

  def self.without_existing(params)
    new(params, destroy_existing: true).perform
  end
end

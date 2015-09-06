# UpdateSubscriber will handle updating metadata and updating the subscriber
# Either in a merge or a full delete of existing metadata
#
# PATCH /subscriber/:id -> with_existing(params) means merging with existing
# PUT /subscriber/:id -> without_existing(params) means deleting the existing
class UpdateSubscriber
  attr_reader :destroy_existing, :metadata, :subscriber, :subscriber_attributes

  def initialize(params, destroy_existing: nil)
    @destroy_existing = destroy_existing
    @metadata = params.fetch('metadata')
    @subscriber_attributes = params.reject { |k, _| k == 'metadata' }

    subscriber_id = params.fetch('id')

    @subscriber = Subscriber.find(subscriber_id)
  end

  def perform
    if destroy_existing
      subscriber.metadata = metadata
    else
      subscriber.metadata.merge!(metadata)
    end

    subscriber.update!(subscriber_attributes)
  end

  def self.with_existing(params)
    new(params, destroy_existing: false).perform
  end

  def self.without_existing(params)
    new(params, destroy_existing: true).perform
  end
end

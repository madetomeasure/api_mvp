class RenderMessage::SubscriberPresenter < Mustache
  attr_reader :subscriber

  def initialize(subscriber)
    @subscriber = subscriber
  end

  def email
    subscriber.email
  end

  def name
    subscriber.name
  end

  def metadata
    subscriber.metadata
  end
end

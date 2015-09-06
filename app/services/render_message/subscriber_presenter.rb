# Handles rendering the mustache templates
class RenderMessage::SubscriberPresenter < Mustache
  attr_reader :subscriber

  delegate :email, :name, :metadata, to: :subscriber

  def initialize(subscriber)
    @subscriber = subscriber
  end
end

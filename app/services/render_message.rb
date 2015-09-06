class RenderMessage
  attr_reader :template, :subscriber
  def initialize(template, subscriber)
    @template = template
    @subscriber = subscriber
  end

  def perform
    Mustache.render(template, SubscriberPresenter.new(subscriber))
  end
end

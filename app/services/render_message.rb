# Provides methods for rendering mustache templates
# in messages using subscriber data
class RenderMessage
  attr_reader :message, :subscriber
  def initialize(message, subscriber)
    @message = message
    @subscriber = subscriber
  end

  def html
    presenter.render(mustache_template(:html, message.html_body))
  end

  def text
    presenter.render(mustache_template(:text, message.text_body))
  end

  private

  def presenter
    SubscriberPresenter.new(subscriber)
  end

  def mustache_template(type, raw_template)
    return '' if raw_template.blank?
    MustacheTemplateCache.fetch("#{type}_#{message.id}", raw_template)
  end
end

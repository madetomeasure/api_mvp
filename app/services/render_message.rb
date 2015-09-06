class RenderMessage
  attr_reader :template, :subscriber
  def initialize(template, subscriber)
    @template = template
    @subscriber = subscriber
  end

  def html
    presenter.render(mustache_template(:html, template.html_body))
  end

  def text
    presenter.render(mustache_template(:text, template.text_body))
  end

  private

  def presenter
    SubscriberPresenter.new(subscriber)
  end

  def mustache_template(type, raw_template)
    return '' if raw_template.blank?
    MustacheTemplateCache.fetch("#{type}_#{template.id}", raw_template)
  end
end

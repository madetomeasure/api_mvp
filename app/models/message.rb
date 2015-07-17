class Message < ActiveRecord::Base
  has_many :parts, class_name: 'MessagePart', autosave: true

  def html=(text)
    return unless text.present?
    parts.html.first_or_initialize(body: text)
  end

  def text=(text)
    return unless text.present?
    parts.text.first_or_initialize(body: text)
  end

  def html_body
    parts.html.first.try(:body)
  end

  def text_body
    parts.text.first.try(:body)
  end

  def multipart?
    parts.length > 1
  end
end

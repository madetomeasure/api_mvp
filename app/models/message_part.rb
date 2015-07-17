class MessagePart < ActiveRecord::Base
  def self.html
    where(mime_type: ContentType.html)
  end

  def self.text
    where(mime_type: ContentType.text)
  end

  def text?
    mime_type == ContentType.text
  end

  def html?
    mime_type == ContentType.html
  end
end

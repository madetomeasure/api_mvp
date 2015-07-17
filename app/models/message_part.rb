class MessagePart < ActiveRecord::Base
  def multipart?
    mime_type == ContentType.multipart
  end

  def plaintext?
    mime_type == ContentType.plaintext
  end

  def html?
    mime_type == ContentType.html
  end
end

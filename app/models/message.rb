=begin
The motivation behind making this only be one model instead of STI (PlainMessage, MultipartMessage, HTMLMessage).
Is that every email is just a message, whether it's plaintext, multipart or html are just descriptors of the same email.
This might turn the class that we're writing into a monstrosity so we can revisit after MVP.
=end
class Message < ActiveRecord::Base
  # Note that the parent_message_id can be itself. Which would be odd

  has_many :message_headers # Headers are required and will contain things like Subject, return path etc.
  has_many :parts # Optional

  def content_type
    message_headers.where(key: "Content-Type")
  end

  def multipart?
    content_type.exists?(value: "multipart/alternative") 
  end

  def plain?
    content_type.exists?(value: "text/plain")
  end

  def html?
    content_type.exists?(value: "text/html")
  end
end


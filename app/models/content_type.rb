class ContentType < MessageHeader
  def self.multipart
    @multipart ||= load_content_type("multipart/alternative")
  end

  def self.plaintext
    @plain ||= load_content_type("text/plain")
  end

  def self.html
    @html ||= load_content_type("text/html")
  end

  private
  # Do note that there are circumstances where we will need to add things 
  # like charset = UTF-8 or boundary = SECURE NONCE
  # I'm treating this like an implementation detail that the adapter layer should cover though
  #
  def self.load_content_type(content_type)
    find_or_create_by(key: "Content-Type", value: content_type) 
  end
end

class ContentType
  MULTIPART = "multipart/alternative"
  PLAINTEXT = "text/plain"
  HTML = "text/html"

  def self.multipart
    MULTIPART
  end

  def self.plaintext
    PLAINTEXT
  end

  def self.html
    HTML
  end
end

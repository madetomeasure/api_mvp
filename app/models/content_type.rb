class ContentType
  MULTIPART = "multipart/alternative"
  TEXT = "text/plain"
  HTML = "text/html"

  def self.multipart
    MULTIPART
  end

  def self.text
    TEXT
  end

  def self.html
    HTML
  end
end

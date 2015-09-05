module ContentType
  extend self

  MULTIPART = "multipart/alternative"
  TEXT = "text/plain"
  HTML = "text/html"

  def multipart
    MULTIPART
  end

  def text
    TEXT
  end

  def html
    HTML
  end
end

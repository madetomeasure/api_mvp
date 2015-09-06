# Handles the content types we accept
# FIXME: This should probably be phased out for mime types
module ContentType
  MULTIPART = 'multipart/alternative'
  TEXT = 'text/plain'
  HTML = 'text/html'

  def multipart
    MULTIPART
  end

  def text
    TEXT
  end

  def html
    HTML
  end

  module_function :multipart, :text, :html
end

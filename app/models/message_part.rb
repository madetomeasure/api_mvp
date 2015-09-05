# == Schema Information
#
# Table name: message_parts
#
#  id         :integer          not null, primary key
#  mime_type  :string           not null
#  body       :text             not null
#  message_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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

# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  subject    :string(77)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  from       :string
#  reply_to   :string
#

# Message has a subject and parts
#
# Subject follows a convention of only being 77 characters or less
# http://stackoverflow.com/questions/1592291/what-is-the-email-subject-length-limit
#
class Message < ActiveRecord::Base
  has_many :parts, class_name: 'MessagePart', autosave: true

  validates :parts, presence: true

  validates_email_format_of :from
  validates_email_format_of :reply_to, allow_nil: true

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

class Message < ActiveRecord::Base
  has_many :message_parts
end

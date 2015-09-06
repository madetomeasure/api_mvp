# == Schema Information
#
# Table name: subscribers
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subscriber < ActiveRecord::Base

  has_many :deliveries

  validates :email, presence: true
  
  validates_email_format_of :email

end

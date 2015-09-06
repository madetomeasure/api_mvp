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

Fabricator(:message) do
  from      'noreply@madetomeasure.io'
  reply_to  { [nil, Faker::Internet.email].sample }
  subject   { Faker::Lorem.sentence }
  html      '<p>things</p>'
  text      { Faker::Company.bs }
end

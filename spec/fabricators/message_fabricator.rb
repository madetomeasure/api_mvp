# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  subject    :string(77)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:message) do
  subject { Faker::Lorem.sentence }
  html "<p>things</p>"
  text { Faker::Company.bs }
end

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

Fabricator(:subscriber) do
  email { Faker::Internet.email }
  name { Faker::Name.name }
end

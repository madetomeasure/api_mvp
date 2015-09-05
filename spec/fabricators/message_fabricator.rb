Fabricator(:message) do
  subject { Faker::Lorem.sentence }
  html "<p>things</p>"
  text { Faker::Company.bs }
end

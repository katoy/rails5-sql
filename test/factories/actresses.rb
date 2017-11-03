# == Schema Information
#
# Table name: actresses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :actress do
    name "MyString"
  end
end

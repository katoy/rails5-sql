# == Schema Information
#
# Table name: movies
#
#  id         :integer          not null, primary key
#  actress_id :integer
#  title      :string(255)
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :movie do
    title "MyString"
  end
end

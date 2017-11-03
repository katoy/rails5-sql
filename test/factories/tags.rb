# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  key        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :tag do
    key "MyString"
  end
end

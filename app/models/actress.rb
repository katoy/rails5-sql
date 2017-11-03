# == Schema Information
#
# Table name: actresses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Actress < ApplicationRecord
  has_many :movies
end

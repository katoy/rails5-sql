# == Schema Information
#
# Table name: actresses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Actress < ApplicationRecord
  acts_as_paranoid

  has_many :movies
end

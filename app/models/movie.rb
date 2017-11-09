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

class Movie < ApplicationRecord
  acts_as_paranoid

  has_many :tags
  belongs_to :actress
end

# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  key        :string(255)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  acts_as_paranoid

  belongs_to :movie, optional: true
end

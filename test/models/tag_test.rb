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

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

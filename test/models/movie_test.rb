# == Schema Information
#
# Table name: movies
#
#  id         :integer          not null, primary key
#  actress_id :integer
#  title      :string(255)
#  year       :integer
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

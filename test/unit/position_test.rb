require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: positions
#
#  id            :integer         not null, primary key
#  portfolio_id  :integer
#  price         :decimal(, )
#  amount        :integer
#  instrument    :string(255)
#  instrument_id :integer
#  typ           :string(255)
#  pl            :decimal(, )
#  created_at    :datetime
#  updated_at    :datetime
#


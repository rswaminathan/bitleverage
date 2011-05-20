require 'test_helper'

class TradeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: trades
#
#  id            :integer         not null, primary key
#  typ           :string(255)
#  price         :decimal(, )
#  amount        :integer
#  order         :string(255)
#  instrument    :string(255)
#  instrument_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#


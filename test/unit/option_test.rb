require 'test_helper'

class OptionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: options
#
#  id            :integer         not null, primary key
#  typ           :string(255)
#  quantity      :integer
#  strike        :decimal(, )
#  expiration    :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  name          :string(255)
#  open_interest :integer         default(0)
#  value         :decimal(, )
#


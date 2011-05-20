class Transaction < ActiveRecord::Base

    belongs_to :option
end

# == Schema Information
#
# Table name: transactions
#
#  id            :integer         not null, primary key
#  buyer_id      :integer
#  seller_id     :integer
#  price         :decimal(, )
#  instrument    :string(255)
#  instrument_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#


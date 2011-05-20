class Currency < ActiveRecord::Base
    has_many :trades, :foreign_key => "instrument_id", :conditions => {:instrument => "Currency"}
    has_many :transactions, :foreign_key => "instrument_id", :conditions => {:instrument => "Currency"}

    def best_bid
        trades.bids.order('price desc').first.price if trades.bids.order('price desc').first
    end

    def best_ask
        trades.asks.order('price asc').first.price if trades.asks.order('price asc').first
    end

end

# == Schema Information
#
# Table name: currencies
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  value         :decimal(, )
#  created_at    :datetime
#  updated_at    :datetime
#  open_interest :integer         default(0)
#


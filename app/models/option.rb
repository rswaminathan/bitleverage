class Option < ActiveRecord::Base
    default_scope order('expiration asc')
    scope :puts, where(:typ => 'put')
    scope :calls, where(:typ => 'call')
    scope :expires_at, lambda { |year, month| where(:expiration => Time.utc(year, month)..(Time.utc(year,month+1)-1.second)) }

    has_many :transactions, :foreign_key => "instrument_id", :conditions => {:instrument => "Option"}
    has_many :trades, :foreign_key => "instrument_id", :conditions => {:instrument => "Option"}


    def best_bid
        trades.bids.order('price desc').first.price if trades.bids.order('price desc').first
    end

    def best_ask
        trades.asks.order('price asc').first.price if trades.asks.order('price asc').first
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


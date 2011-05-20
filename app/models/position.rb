class Position < ActiveRecord::Base
    belongs_to :portfolio

    scope :requires_margin, where(:instrument => "Option", :typ => "ask")
    scope :options, where(:instrument => "Option")
    scope :currencies, where(:instrument => "Currency")
    scope :by_instrument, lambda {|instrument, instrument_id| where(:instrument => instrument,
                                                                   :instrument_id => instrument_id)} 

    scope :by_underlying, lambda {|instrument, instrument_id| where(:underlying => instrument,
                                                                   :underlying_id => instrument_id)} 
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


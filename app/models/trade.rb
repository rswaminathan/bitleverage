class Trade < ActiveRecord::Base
    belongs_to :user
    belongs_to :option, :foreign_key => :instrument_id, :counter_cache => :open_interest
    after_create :increment_counter_cache
    after_destroy :decrement_counter_cache


    scope :bids, where(:typ => 'bid')
    scope :asks, where(:typ => 'ask')
    scope :by_instrument, lambda {|instrument, instrument_id| where(:instrument => instrument,
                                                                   :instrument_id => instrument_id)} 

    private

    def increment_counter_cache
        instrument.classify.constantize.increment_counter(:open_interest, instrument_id)
    end

    def decrement_counter_cache
        instrument.classify.constantize.decrement_counter(:open_interest, instrument_id)
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


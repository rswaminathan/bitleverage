class Portfolio < ActiveRecord::Base
    belongs_to :user
    has_many :positions
    has_many :options, :through => :positions, :foreign_key => :instrument_id, :conditions => {:instrument => "Option"}
    has_many :currencies, :through => :positions, :foreign_key => :instrument_id, :conditions => {:instrument => "Currency"}


    def create_or_update_position(amount, instrument, instrument_id, typ=nil)
        existing = positions.by_instrument(instrument, instrument_id).where(:typ => typ)
        if existing.size == 0
            positions.create(:amount => amount, :instrument => instrument, :instrument_id => instrument_id,
                            :typ => typ)
        else
            existing.first.increment!(:amount, amount)
        end
    end


    def remove_from_position(amount, instrument, instrument_id, typ = nil)
        existing = positions.by_instrument(instrument, instrument_id).where(:typ => typ).first
        existing.decrement!(:amount, amount)
        if existing.amount < 0.00001
            existing.destroy
        end
    end

    def usd

        #TODO: support other currencies
        positions.currencies.sum(:amount)
    end

    def usd_in_margin
        margin = 0
        positions.where(:instrument => "Option", :typ => "ask").each do |p|
            margin+= p.amount if Option.find(p.instrument_id).typ == "call" #check underlying later
        end
        return margin
    end

    def funds_in_margin
        margin = 0
        positions.where(:instrument => "Option", :typ => "ask").each do |p|
            o = Option.find(p.instrument_id) #check underlying later
            if o.typ == "put"
                margin += o.strike*p.amount
            end
        end
        return margin
    end

    def value
        v = 0
        positions.each do |p|
            instrument = p.instrument.classify.constantize.find(p.instrument_id)
            v += instrument.value * p.amount
        end
        return v
    end

end

# == Schema Information
#
# Table name: portfolios
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  funds      :decimal(, )
#  created_at :datetime
#  updated_at :datetime
#


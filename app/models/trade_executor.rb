class TradeExecutor

    include ActiveModel::Validations
    validates :instrument, :presence => true, :format => {:with => /Currency|Option/}
    validates :instrument_id, :presence => true


    def initialize(instrument, instrument_id)
        @instrument = instrument
        @instrument_id = instrument_id
    end


    def trade
        #Get top of queue, and start from there
        best_bid = Trade.bids.by_instrument(@instrument, @instrument_id).first
        best_ask = Trade.asks.by_instrument(@instrument, @instrument_id).first
        execute(best_bid, best_ask) if best_bid && best_ask && best_bid.price >= best_ask.price
    end


    def valid_option_bid!(trade)
        trade.user.portfolio.funds - trade.user.portfolio.funds_in_margin > trade.price*trade.amount
    end

    #check if valid, else destroy trade
    def valid_option_ask!(trade)
        option = Option.find(trade.instrument_id)
        if optiontyp == "call"
            if trade.user.portfolio.usd - trade.user.portfolio.usd_in_margin >= trade.amount
                true
            else
                trade.destroy
                false
            end
        elsif option.typ == "put"
            if trade.user.portfolio.funds - trade.user.portfolio.funds_in_margin >= option.strike*trade.price
                true
            else
                trade.destroy
                false
            end
        end
    end

    def execute(bid, ask)
        sale_price = (bid.price + ask.price)/2
        if @instrument == "Option"
            #if selling, either have position, or margin requirements, else delete
            if valid_option_ask!(ask) && valid_option_bid!(bid)
                #which one is more
                if bid.amount > ask.amount
                    bid.user.create_or_update_position(ask.amount, @instrument, @instrument_id, "bid")
                    bid.user.portfolio.decrement!(:funds,sale_price*ask.amount)
                    ask.user.remove_from_position(ask.amount, @instrument, @instrument_id, "ask")
                    ask.user.portfolio.increment!(:funds,sale_price*ask.amount)
                    bid.decrement!(:amount, ask.amount)
                    ask.destroy
                else
                    bid.user.create_or_update_position(bid.amount, @instrument, @instrument_id, "bid")
                    bid.user.portfolio.decrement!(:funds,sale_price*ask.amount)
                    ask.user.remove_from_position(bid.amount, @instrument, @instrument_id, "ask")
                    ask.user.portfolio.increment!(:funds,sale_price*ask.amount)
                    ask.decrement!(:amount, bid.amount)
                    bid.destroy
                    #TODO: what if they are equal?
                end
            end
        elsif @instrument == "Currency"
            if can_buy_usd!(bid) && can_sell_usd!(ask)
                if bid.amount > ask.amount
                    bid.user.create_or_update_position(ask.amount, @instrument, @instrument_id)
                    bid.user.portfolio.decrement!(:funds,sale_price*ask.amount)
                    ask.user.remove_from_position(bid.amount, @instrument, @instrument_id)
                    ask.user.portfolio.increment!(:funds,sale_price*ask.amount)
                    bid.decrement!(:amount, ask.amount)
                    ask.destroy
                else
                    bid.user.create_or_update_position(bid.amount, @instrument, @instrument_id)
                    bid.user.portfolio.decrement!(:funds,sale_price*ask.amount)
                    ask.user.remove_from_position(bid.amount, @instrument, @instrument_id)
                    ask.user.portfolio.increment!(:funds,sale_price*ask.amount)
                    ask.decrement!(:amount, bid.amount)
                    bid.destroy
                end
            end
        end
    end

    def can_buy_usd!(trade)
        if trade.user.portfolio.funds - trade.user.portfolio.funds_in_margin >= trade.price*trade.amount
            true
        else
            trade.destroy
            false
        end
    end

    def can_sell_usd!(trade)
        if trade.user.portfolio.usd - trade.user.portfolio.usd_in_margin >= trade.amount
            true
        else
            trade.destroy
            false
        end
    end

end

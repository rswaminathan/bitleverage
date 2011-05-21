class TradesController < ApplicationController
    before_filter :authenticate_user!
    before_filter :correct_user, :only => [:edit, :update]
    before_filter :verify_instrument, :only => [:new]

    def new
        @trade = Trade.new
    end

    def edit
        render 'new'
    end

    def create
        @trade = Trade.new(params[:trade])
        flash[:notice] = current_user.make_trade(@trade)
        TradeExecutor.new(@trade.instrument, @trade.instrument_id).delay.trade
        redirect_to portfolio_path
    end

    def destroy
        @trade = Trade.find(params[:id])
        if @trade.user == current_user
            @trade.destroy
            flash[:notice] = "Cancelled trade"
        end
        redirect_to portfolio_path
    end

    private

    def correct_user
        @trade = Trade.find(params[:id])
        current_user == @trade.user
        @instrument = @trade.instrument.classify.constantize.find(@trade.instrument_id)
    end

    def verify_instrument
        instrument = params[:i]
        if instrument == "option" || "currency"
            @instrument = instrument.classify.constantize.find(params[:id])
        else
            flash[:error] = "Not a valid instrument"
            render 'new'
        end
    end
end

class OptionsController < ApplicationController

    def index
        redirect_to options_expires_path(Time.now.year, Time.now.mon)
    end

    def expires
        year = params[:year].to_i
        month = params[:month].to_i
        @options = Option.by_strike.expires_at(year, month)
    end

    def show
        @instrument = Option.find(params[:id])
        @trade  = Trade.new
        render 'trades/new'
    end
end

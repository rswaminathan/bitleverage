class CurrenciesController < ApplicationController

    def index
        @currencies = Currency.all
    end

    def show
        @instrument = Currency.find(params[:id])
        @trade = Trade.new
        render 'trades/new'
    end

end

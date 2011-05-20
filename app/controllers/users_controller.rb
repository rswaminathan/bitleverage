class UsersController < ApplicationController
    before_filter :authenticate_user!, :only =>[:portfolio]

    def portfolio
        @portfolio = current_user.portfolio
    end

    def add_funds
    end

    def notify
        txn = params[:txn_id]
        user = User.find_by_id(params[:custom])
        amount = params[:amount]
        cc = params[:currency_code]
        if verify(txn, amount) == "ok"
            if cc == "USD"
                c = Currency.find_by_name("USD")
                portfolio =  user.portfolio.positions.find_or_create_by_instrument("Currency") {|p| p.instrument_id = c.id}
                portfolio.increment!(:amount, amount.to_i)
            elsif cc = "BTC"
                user.portfolio.funds.increment!(amount)
            end
        end
    end

    def verify(txn,amount, merch_id = "12043")
        uri = URI.parse("https://mtgox.com/code/gateway/checkTxn.php")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Post.new(uri.request_uri, {'txn_id' => txn_id, 'merchID' => merch_id, 'amount' => amount})

        response = http.request(request)
        response.body
    end

end
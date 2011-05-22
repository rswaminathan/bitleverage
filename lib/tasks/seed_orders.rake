namespace :seed_orders do

    desc "Create options "
    task :options, [:year, :month, :current_exchange] => :environment do |t, args|
        u = User.find_by_email("swamirahul@hotmail.com")
        year = args.year.to_i
        month = args.month.to_i
        current_exchange = args.current_exchange.to_d
        Option.expires_at(year, month).each do |o|
            if o.typ == "call"
                inherent = 1/current_exchange - o.strike
                premium = inherent > 0 ? inherent : 0
                time_premium = month - Time.now.mon + (year - Time.now.year)*12
                tp = time_premium * 0.1
                Trade.create(:typ => "bid", :price => premium + 0.01 + tp*0.1, :amount => 2, :instrument => "Option",
                             :instrument_id => o.id, :user_id => u.id)
                Trade.create(:typ => "ask", :price => 1.5*(premium + 0.01) + tp*0.2, :amount => 2, :instrument => "Option",
                             :instrument_id => o.id, :user_id => u.id)
            elsif o.typ == "put"
                inherent = o.strike - 1/current_exchange
                premium = inherent > 0 ? inherent : 0
                time_premium = month - Time.now.mon + (year - Time.now.year)*12
                tp = time_premium * 0.1
                Trade.create(:typ => "bid", :price => premium + 0.01 + tp, :amount => 2, :instrument => "Option",
                             :instrument_id => o.id, :user_id => u.id)
                Trade.create(:typ => "ask", :price => 2*(premium + 0.1) + tp, :amount => 2, :instrument => "Option",
                             :instrument_id => o.id, :user_id => u.id)
            end
        end
        puts "Created seed orders"
    end

end


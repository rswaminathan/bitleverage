namespace :create_instruments do

    desc "Create options "
    task :options, [:year, :month] => :environment do |t, args|
        [0.01, 0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.50,1.00].each do |s|
            exp = Time.utc(args.year, args.month) - 1.second
            Option.create(:name => "BTC/USD-#{exp.year}.#{exp.month}.#{exp.day}-#{s}-CALL", :typ => "call", :strike => s, :expiration => exp)
            Option.create(:name => "BTC/USD-#{exp.year}.#{exp.month}.#{exp.day}-#{s}-PUT", :typ => "put", :strike => s, :expiration => exp)
        end
        puts "Created options"
    end

end

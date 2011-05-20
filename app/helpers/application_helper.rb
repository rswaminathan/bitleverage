module ApplicationHelper

    def get_option_hint(option)
        if option.class == Currency
            "Enter amount of USD to buy/sell"
        elsif option.class == Option
            if option.typ == "call"
                "Each option represents the ability to buy $1 for #{option.strike}BTC on #{option.expiration}."
            elsif option.typ == "put"
                "Each option represents the ability to buy #{option.strike}BTC for $1 on #{option.expiration}."
            end
        end
    end

end

class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    has_one :portfolio
    has_many :withdrawal_requests
    has_many :bought, :class_name => 'Transaction', :foreign_key => "buyer_id"
    has_many :sold, :class_name => 'Transaction', :foreign_key => "seller_id"
    has_many :trades
    has_many :positions, :through => :portfolio

    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me

    delegate :create_or_update_position, :to => :portfolio
    delegate :remove_from_position, :to => :portfolio
    

    after_save :create_portfolio
    #Asynchronous with delayed job

    def make_currency_trade(trade)
        instrument = trade.instrument.classify.constantize.find(trade.instrument_id)
        #make sure you have what you are selling
        if trade.typ == "ask"
            if portfolio.usd >= trade.amount
                trade.save
                "Trade executed."
            else 
                "You do not have sufficient USD to sell."
            end
        elsif trade.typ == "bid"
            if portfolio.funds >= trade.amount*trade.price
                trade.save
                "Trade executed. Check portfolio page."
            else
                "You do not have sufficient funds."
            end
        end
    end

    def make_trade(trade)
        #for option trade only
        trade.user = self
        if trade.instrument == "Currency"
            make_currency_trade(trade)
        elsif trade.instrument == "Option"
            make_option_trade(trade)
        else
            "Invalid instrument "
        end
        #spawn tradeexecutor in new thread
    end


    def make_option_trade(trade)
        option = trade.instrument.classify.constantize.find(trade.instrument_id)
        if option.typ == "call"
            if trade.typ == "bid"
                if portfolio.funds > trade.amount*trade.price
                    trade.save
                    "Trade executed. Check your portfolio page to see pending orders."
                else 
                    "You do not have sufficient funds."
                end
            elsif trade.typ == "ask"
                if portfolio.usd > trade.amount
                    trade.save
                    "Trade executed. Check your portfolio page to view pending orders."
                else
                    "You cannot write calls without covering your total position. You need at least
                    #{trade.amount}USD in your account."
                end
            end
        elsif option.typ == "put"
            if trade.typ == "bid"
                if portfolio.funds > trade.amount*trade.price
                    trade.save
                    "Trade executed. Check portfolio page to see pending orders."
                else
                    "You do not have sufficient funds. You need #{trade.amount*trade.price}BTC"
                end
            elsif trade.typ = "ask"
                if portfolio.funds > trade.amount*option.strike
                    trade.save
                    "Trade executed. Check portfolio page to see pending orders"
                else
                    "You do not have sufficient funds to cover you put. You need at least 
                    #{option.strike*trade.amount}BTC in your account to cover your position."
                end
            end
        end
    end


    private

    def create_portfolio
        portfolio.create!(:funds => 0.0)
    end

end


# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#


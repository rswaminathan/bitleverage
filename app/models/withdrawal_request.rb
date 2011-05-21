class WithdrawalRequest < ActiveRecord::Base

    belongs_to :user
    validates :typ, :presence => true
    validates :address, :presence => true
    validates :funds, :presence => true
    after_save :remove_from_funds
    
    validate :has_enough_funds

    private
    
    def has_enough_funds
        errors.add(:funds, "You cannot withdraw that much") if funds >= user.portfolio.funds - user.portfolio.funds_in_margin
        errors.add(:funds, "You have to withdraw more than 0") if funds == 0
    end

    def remove_from_funds
        ActiveRecord::Base.transaction do
            user.portfolio.decrement!(:funds, user.portfolio.funds)
        end
    end

end

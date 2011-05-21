class WithdrawalRequestsController < ApplicationController
    before_filter :authenticate_user!

    def create
        @withdrawal = WithdrawalRequest.new(params[:withdrawal_request])
        @withdrawal.user = current_user
        if @withdrawal.save
            flash[:success] = "Withdrawal request successful."
            redirect_to account_funding_path
        else
            flash.now[:error] = "There was an error with your witdrawal request."
            render 'users/account_funding'
        end
    end

end

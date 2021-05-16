class Stripe::AccountsController < ApplicationController
  def show
    account = Stripe::Account.retrieve(params[:id])
    render json: account
  end

  def create
    if current_user.stripe_id.blank?
      account = Stripe::Account.create({
        type: 'standard',
      })
      current_user.update(stripe_id: account.id)
    end
    account_link = Stripe::AccountLink.create({
      account: current_user.stripe_id,
      refresh_url: 'http://localhost:8080/account/dashboard',
      return_url: 'http://localhost:8080/account/dashboard',
      type: 'account_onboarding',
    })
    render json: account_link
  end
end

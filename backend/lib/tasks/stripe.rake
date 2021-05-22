namespace :stripe do
  task charge: :environment do
    total_amount = Payment.where(is_paid: false).sum(:amount)

    card = Rails.application.credentials.dig(:stripe, :charge, :card)
    token = Stripe::Token.create(card: card)

    Stripe::Charge.create({
      amount: total_amount,
      currency: 'jpy',
      source: token.id,
      description: '',
    })
  end

  task transfer: :environment do
    payments = Payment.where(is_paid: false).includes(:user)
    total_amount = payments.sum(:amount)

    transfer_group = Date.today.to_s
    payments.each do |payment|
      Stripe::Transfer.create({
        amount: total_amount,
        currency: 'jpy',
        destination: payment.user.stripe_id,
        transfer_group: transfer_group,
      })
    end
    payments.update_all(is_paid: true, transfer_group: transfer_group)
  end
end

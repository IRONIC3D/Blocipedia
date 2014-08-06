class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Blocipedia Monthly Subscription - #{current_user.full_name}",
     amount: 500 
     # We're like the Snapchat for Wikipedia. But really, 
     # change this amount. Stripe won't charge $9 billion.
   }
  end

  def create
    # Amount in centes
    @amount = params[:amount]

    # Create a Stripe customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id
      amount: @amount,
      description: "Blocipedia Monthly Subscription",
      currency: 'aud'
    )

    flash[:success] = "Thank you"
    # redirect_to user_path(current_user)
    redirect_to wikis_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.

  rescue Stripe::CardError => e
    flash[:error] = e.messages
    redirect_to new_charge_path
  end
end

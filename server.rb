require 'sinatra'
require 'stripe'
require 'json'

Stripe.api_key = 'sk_test_your_secret_key'  # Replace with your actual secret key

post '/create-checkout-session' do
  content_type :json

  session = Stripe::Checkout::Session.create({
    ui_mode: 'embedded',
    line_items: [{
      price: 'price_1234', # Replace with your actual Price ID
      quantity: 1,
    }],
    mode: 'payment',
    return_url: 'http://localhost:4567/return.html?session_id={CHECKOUT_SESSION_ID}',
  })

  { clientSecret: session.client_secret }.to_json
end

get '/' do
  'Stripe backend is running.'
end


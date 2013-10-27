require 'spec_helper'

describe "Create payment on successful charge" do

  let(:event_data) do
    {
      "id" => "evt_2mrtyjEbsOCC9V",
      "created" => 1382259957,
      "livemode" => false,
      "type" => "charge.succeeded",
      "data" => {
        "object" => {
          "id" => "ch_2mrtVWGvmLCW8u",
          "object" => "charge",
          "created" => 1382259956,
          "livemode" => false,
          "paid" => true,
          "amount" => 999,
          "currency" => "usd",
          "refunded" => false,
          "card" => {
            "id" => "card_2mrtjxzEgBWaKi",
            "object" => "card",
            "last4" => "4242",
            "type" => "Visa",
            "exp_month" => 10,
            "exp_year" => 2017,
            "fingerprint" => "KniHAbbP8edNQ7pX",
            "customer" => "cus_2mrtGr8E8TYlqT",
            "country" => "US",
            "name" => nil,
            "address_line1" => nil,
            "address_line2" => nil,
            "address_city" => nil,
            "address_state" => nil,
            "address_zip" => nil,
            "address_country" => nil,
            "cvc_check" => "pass",
            "address_line1_check" => nil,
            "address_zip_check" => nil
            },
            "captured" => true,
            "balance_transaction" => "txn_2mrtbaOWOnJgmD",
            "failure_message" => nil,
            "failure_code" => nil,
            "amount_refunded" => 0,
            "customer" => "cus_2mrtGr8E8TYlqT",
            "invoice" => "in_2mrtke0Zakn9Xt",
            "description" => nil,
            "dispute" => nil,
            "metadata" => {},
            "fee" => 59,
            "fee_details" => [
              {
                "amount" => 59,
                "currency" => "usd",
                "type" => "stripe_fee",
                "description" => "Stripe processing fees",
                "application" => nil
              }
            ]
          }
          },
          "object" => "event",
          "pending_webhooks" => 1,
          "request" => "iar_2mrtkmb1oswg1l"
        }

      end

      it "creates a payment with the webhook from stripe for charge succeeded",  :vcr do
        post "/stripe_events", event_data
        expect(Payment.count).to eq(1)
      end

      it "creates the payment associated with the user", :vcr do
        alice = Fabricate(:user, customer_token: "cus_2mrtGr8E8TYlqT")
        post "/stripe_events", event_data
        expect(Payment.first.user).to eq(alice)
      end

      it "creates the payment with the amount", :vcr do
        alice = Fabricate(:user, customer_token: "cus_2mrtGr8E8TYlqT")
        post "/stripe_events", event_data
        expect(Payment.first.amount).to eq(999)
      end

      it "creates the payment with the reference id", :vcr do
        alice = Fabricate(:user, customer_token: "cus_2mrtGr8E8TYlqT")
        post "/stripe_events", event_data
        expect(Payment.first.reference).to eq("ch_2mrtVWGvmLCW8u")
      end


    end
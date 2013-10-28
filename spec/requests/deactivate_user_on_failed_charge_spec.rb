require 'spec_helper'


describe "Deactivate user on failed charge" do
  let(:event_data) do
      {
        "id" => "evt_2pa23Sg2vz10jN",
        "created" => 1382885464,
        "livemode" => false,
        "type" => "charge.failed",
        "data" => {
          "object" => {
            "id" => "ch_2pa2PYOfM9c295",
            "object" => "charge",
            "created" => 1382885464,
            "livemode" => false,
            "paid" => false,
            "amount" => 999,
            "currency" => "usd",
            "refunded" => false,
            "card" => {
              "id" => "card_2pa2axgaPxksn4",
              "object" => "card",
              "last4" => "0341",
              "type" => "Visa",
              "exp_month" => 10,
              "exp_year" => 2014,
              "fingerprint" => "jgF2cmYh5sLwXfxW",
              "customer" => nil,
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
              "captured" => false,
              "balance_transaction" => nil,
              "failure_message" => "Your card was declined.",
              "failure_code" => "card_declined",
              "amount_refunded" => 0,
              "customer" => "cus_2nJ6lEt7NUfqVV",
              "invoice" => nil,
              "description" => "failed payment",
              "dispute" => nil,
              "metadata" => {},
              "fee" => 0,
              "fee_details" => []
            }
            },
            "object" => "event",
            "pending_webhooks" => 2,
            "request" => "iar_2pa21ts0f0FdZC"
        }

      end

      it "deactives a user with the web hook data from stripe for charge failed", :vcr do
        alice = Fabricate(:user, customer_token: "cus_2nJ6lEt7NUfqVV")
        post "/stripe_events", event_data
        expect(alice.reload).not_to be_active
      end


    end
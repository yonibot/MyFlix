require 'spec_helper'

describe ForgotPasswordsController do
  describe "POST create" do
    context "with blank input"

      it "redirects to the forgot_password page" do
        post :create, email: ""
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        post :create, email: ""
        expect(flash[:error]).not_to be_blank
      end

    context "with existing email" do
      it "redirects to the forgot password confirmation page" do
        Fabricate(:user, email: "joe@example.com")
        post :create, email: "joe@example.com"
        expect(response).to redirect_to forgot_password_confirmation_path
      end
      it "sends out an email to the email address" do
        Fabricate(:user, email: "joe@example.com")
        post :create, email: "joe@example.com"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@example.com"])
      end
    end

    context "with non-existing email" do
      it "redirects to the forgot password page" do
        Fabricate(:user, email: 'archie@example.com')
        post :create, email: "john@stewart.com"
        expect(response).to redirect_to forgot_password_path
      end
      it "shows an error message" do
        Fabricate(:user, email: 'archie@example.com')
        post :create, email: "john@stewart.com"
        expect(flash[:error]).to eq("No user found with that email address.")
      end
    end

  end


end
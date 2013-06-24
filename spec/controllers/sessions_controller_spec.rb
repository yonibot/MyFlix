require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    context "with valid credentials" do
      it "puts the signed in user in the session" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(session[:user_id]).to eq(alice.id)
      end
      it "redirects to the home page" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(response).to redirect_to home_path
      end
      it "sets the notice" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(flash[:notice]).not_to be_blank
      end

    end

    context "with invalid credentials" do
      it "sets error notice" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + 'asdfasdf'
        expect(flash[:error]).not_to be_blank
      end
      it "does not put signed in user in the session" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + 'asdfasdf'
        expect(session[:user_id]).to be_nil
      end
      it "redirects to login page" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + 'asdfasdf'
        expect(response).to redirect_to login_path
      end
    end
  end
end
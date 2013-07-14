require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET new_with_invitation_token" do
    it "renders the :new view template" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end

    it "sets @user with recipient's email" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end

    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

    it "redirects to expired token page for invalid tokens" do
      get :new_with_invitation_token, token: 'ASDFASDF'
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "GET show" do
    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: 3}
    end

    it "sets the @user variable" do
      set_current_user
      alice = Fabricate(:user)
      get :show, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end

    it "displays all of the user's videos"
    it "displays all of the user's reviews"
    it "displays the number of reviews"
    it "displays the number of videos in the user's collection"
    it "renders login template if user is not signed in"
  end

  describe "POST create" do

    context "with valid info" do
      it "creates the user" do
        # post :create, user: { email: "kevin@example.com", email_confirmation: "kevin@example.com", password: "password", full_name: "Kevin Wang" }
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end
      it "redirects to home page" do
        post :create, user: { email: "kevin@example.com", password: "password", full_name: "Kevin Wang" }
        expect(response).to redirect_to home_path
      end
    
      it "makes the user follow the inviter" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com' )
        post :create, user: {email: 'joe@example.com', password: 'password', full_name: 'Joe Doe'}, invitation_token: invitation.token
        joe = User.where(email: 'joe@example.com').first
        expect(joe.follows?(alice)).to be_true
      end
      it "makes the inviter follow the user" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com' )
        post :create, user: {email: 'joe@example.com', password: 'password', full_name: 'Joe Doe'}, invitation_token: invitation.token
        joe = User.where(email: 'joe@example.com').first
        expect(alice.follows?(joe)).to be_true
      end
      it "expires the invitation upon acceptance" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com' )
        post :create, user: {email: 'joe@example.com', password: 'password', full_name: 'Joe Doe'}, invitation_token: invitation.token
        expect(Invitation.first.token).to be_nil
      end

    end

    context "with invalid info" do
      it "does not create the user" do
        post :create, user: { email: "kevin@example.com", full_name: "Kevin Wang" }
        expect(User.count).to eq(0)
      end
      it "renders the new user template" do
        post :create, user: { email: "kevin@example.com", full_name: "Kevin Wang" }
        expect(response).to render_template :new
      end
      it "sets @user" do
        post :create, user: { email: "kevin@example.com", full_name: "Kevin Wang" }
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context "sending emails" do

      after { ActionMailer::Base.deliveries.clear }

      it "sends email to the user with valid input" do
        post :create, user: { email: "kevin@example.com", password: "password", full_name: "Kevin Wang" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(['kevin@example.com'])
      end
      
      it "sends out email containing the user's name with valid input" do
        post :create, user: { email: "kevin@example.com", password: "password", full_name: "Kevin Wang" }
        expect(ActionMailer::Base.deliveries.last.body).to include("Kevin Wang")
      end
 
      it "does not send out email with invalid input" do
        post :create, user: { email: "kevin@example.com", full_name: "Kevin Wang" }
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end

  end
end










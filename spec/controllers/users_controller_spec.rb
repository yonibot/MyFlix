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
    it_behaves_like "requires authenticated user" do
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
    context "successful user signup" do

      it "redirects to the home page" do
        result = double(:sign_up_result, successful?: true)
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: { email: "kevin@example.com", password: "password", full_name: "Kevin Wang" }
        expect(response).to redirect_to home_path
      end

    end

    context "failed user signup" do
      it "renders the new template" do
        result = double(:charge, successful?: false, error_message: "Your card was declined.")
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '1231241'
        expect(response).to render_template :new
      end

      it "sets the flash error message" do
        result = double(:charge, successful?: false, error_message: "Your card was declined.")
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '1231241'
        expect(flash[:error]).to be_present
      end
    end

  end
end










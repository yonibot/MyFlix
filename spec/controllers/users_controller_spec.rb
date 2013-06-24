require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid info" do
      it "creates the user" do
        # post :create, user: { email: "kevin@example.com", email_confirmation: "kevin@example.com", password: "password", full_name: "Kevin Wang" }
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end
      it "redirects to home page" do
        post :create, user: { email: "kevin@example.com", email_confirmation: "kevin@example.com", password: "password", full_name: "Kevin Wang" }
        expect(response).to redirect_to home_path
      end
    end
    context "without invalid info" do
      it "does not create the user" do
        post :create, user: { email: "kevin@example.com", password: "password", full_name: "Kevin Wang" }
        expect(User.count).to eq(0)
      end
      it "renders the new user template" do
        post :create, user: { email: "kevin@example.com", password: "password", full_name: "Kevin Wang" }
        expect(response).to render_template :new
      end
      it "sets @user" do
        post :create, user: { email: "kevin@example.com", password: "password", full_name: "Kevin Wang" }
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end
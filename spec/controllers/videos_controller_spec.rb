require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id 
      video = Fabricate(:video)
      get :show, id:video.id
      expect(assigns(:video)).to eq(video)
    end

    it "redirects to login page for unauthenticated users" do
      video = Fabricate(:video)
      get :show, id:video.id
      expect(response).to redirect_to login_path
    end

    # # Unnecessary since it tests rails functionality
    # it "renders the show template" do
    #   session[:user_id] = Fabricate(:user).id 
    #   video = Fabricate(:video)
    #   get :show, id: video.id
    #   expect(response).to render_template :show
    # end
  end

  describe "POST search" do
    it "sets the @results variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: "Futurama")
      post :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end

    it "redirects to login page for unauthenticated users" do
      futurama = Fabricate(:video, title: "Futurama")
      post :search, search_term: 'rama'
      expect(response).to redirect_to login_path
    end
  end


  describe ""













end
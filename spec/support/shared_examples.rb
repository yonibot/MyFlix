shared_examples "requires authenticated user" do
  it "redirects to the sign in page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to login_path
  end
end

shared_examples "requires admin user" do
  it "redirects to the home page" do
    set_current_user
    action
    expect(response).to redirect_to home_path
  end
end

shared_examples "tokenable" do
  it "generates a random token when the user is created" do
    expect(object.token).to be_present
  end
end
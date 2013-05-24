require "spec_helper"

feature "Log in" do

  scenario "Log in with valid credentials" do
    log_in
  end

  scenario "Log in with invalid credentials" do
    log_in_with :username => "invaliduser", :password => "invalidpassword"
    page.should have_content("Authentication failed, please check your Username and Password")
  end

  scenario "Log in with no username or password" do
    log_in_with :username => "", :password => ""
    page.should have_content("Authentication failed, please check your Username and Password")
  end

  scenario "Log in with no username" do
    log_in_with :username => "", :password => "somepassword"
    page.should have_content("Authentication failed, please check your Username and Password")
  end

  scenario "Log in with no password" do
    log_in_with :username => "invaliduser", :password => ""
    page.should have_content("Authentication failed, please check your Username and Password")
  end
end


feature "Log out" do
  
  scenario "Logout" do
    log_in
    log_out
    page.should have_content("Remember me")
  end
end
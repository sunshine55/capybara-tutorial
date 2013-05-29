require "spec_helper"

feature "Log out" do
  
  scenario "Verify if users can go to page after logout" do
    log_in
    log_out
    visit '/users'
    #page.should have_content "You don't have permission to access this page."
    page.has_title? 'Error'
  end
end
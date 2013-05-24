require "spec_helper"

feature "Feature 1" do

  background do
    profile_page.login_and_go_to_page    
  end

  scenario "scenario 1" do
    
  end

  scenario "scenario 1" do
    
  end
end


feature "Feature 2" do
  
  background do
    profile_page.login_and_go_to_page
  end

  xscenario "xscenario 1" do
    
  end

  xscenario "xscenario 2" do
    
  end
end

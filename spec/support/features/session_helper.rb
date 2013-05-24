module Features
  
  module SessionHelper

    class << self
      attr_accessor :users

      def configure
        yield self  
      end
    end

    def log_in
      log_in_with :username => SessionHelper.users.default.username, :password => SessionHelper.users.default.password
      page.should have_content("admin")
    end

    def log_in_with credentials
      visit ""
      fill_in "username", :with => credentials[:username]
      fill_in "password", :with => credentials[:password]
      click_link_or_button "Login"
    end

    def log_out
      click_link_or_button "admin"
      click_link_or_button "Logout"
    end

    def loaded?
      page.has_content?("admin")
    end
  end
end
require 'page/page'

module Pages
  
  class ProfilePage < Page::Base

    def click_box_icon button
      find(button).click
    end

    def set_page_order value
      # using xpath
      # to maintain the scope of the selector you could wrap it in a within block
      find("option[value='"+value+"']").click
    end

    def fill_table_search text
      # if field must end with an enter hit, there are many approaches: native.send_keys(:return), execute_script
      within '#DataTables_Table_0_filter' do
        find("input[type='text']").set(text)
      end
    end

    def sort_table_on_field field
      find('th', :text => field).click
    end

    def choose_member number
      find(:xpath, "(//a[@class='btn btn-info'])["+number+"]").click
    end

    def edit_member credentials
      find(:xpath, "//input[@name='firstname']").set credentials[:firstname]
      find(:xpath, "//input[@name='lastname']").set credentials[:lastname]
      find(:xpath, "//input[@name='phone']").set credentials[:phone]
      find(:xpath, "//input[@name='username']").set credentials[:username]
      find(:xpath, "//input[@name='password']").set credentials[:password]
    end
  end
end
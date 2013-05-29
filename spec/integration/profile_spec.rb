require "spec_helper"

feature "All Member page" do

  background do
    log_in
  end

  scenario "Check setting button" do
    profile_page.click_box_icon '.btn-setting'
    page.should have_content 'Settings'
    profile_page.defocus_current_element
  end

  scenario "Check minimize button" do
    profile_page.click_box_icon '.btn-minimize'
    page.should_not have_content 'Ben Fleminton'
    #page.has_no_text? '29 entries'
  end

  scenario "Check close table button" do
    profile_page.click_box_icon '.btn-close'
    page.has_no_table? '#DataTables_Table_0'
  end

  scenario "Verify table listing capability with 25 entries" do
    profile_page.set_page_order '25'
    page.should have_content 'Showing 1 to 25 of 29 entries'
  end

  scenario "Verify table search capability" do
    profile_page.fill_table_search 'ben'
    page.should have_content 'Ben Fleminton'
  end

  scenario "Verify table order capability upon Full Name" do
    profile_page.sort_table_on_field 'Full Name'
    first(:xpath, "//tr[@class='odd']/td").text.should eq 'Yuri Sino'
  end
end

feature "Individual member page" do

  background do
    log_in
  end

  # using xscenario for pending test case (color: yellow, status: pending, no pass nor fail)
  scenario "Edit member" do
    profile_page.choose_member '2'
    profile_page.edit_member :firstname => 'Don', :lastname => 'Kim', :phone => '111-222-3344', :username => "kim", :password => 'notkidding'
    click_link_or_button 'Cancel'
  end
end
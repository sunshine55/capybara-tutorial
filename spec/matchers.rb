RSpec::Matchers.define :have_error do |expected_error_text|
  match do |page|
    page.find(".ErrorText", :text => expected_error_text)
  end
end
# Use custom matchers to make test more readable and to avoid duplication. Such as:

#RSpec::Matchers.define :have_error do |expected_error_text|
#  match do |page|
#    page.find(".ErrorText", :text => expected_error_text)
#  end
#end

# For a more complex example, see https://gist.github.com/1233333
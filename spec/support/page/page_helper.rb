require 'active_support/core_ext/string'

module Page

  module PageHelper

    include Capybara::DSL
    include Features::SessionHelper
    include RSpec::Expectations
    include RSpec::Matchers    

    @@test_run_id = Time.now.to_i

    def wait_for_ajax
      wait_until { page.evaluate_script "jQuery.active === 0" }    
    end

    def fill_in_fields fields
      fields.each do | field_name, value |    
        fill_in field_name.to_s, :with => value
      end      
    end

    def fill_in_and_defocus locator, options={}      
      fill_in locator, options
      defocus_current_element
    end

    def defocus_current_element
      page.execute_script "$(document.activeElement).blur()"
      #find("body").click
    end

    def select_with_javascript value, options={}      
      page.execute_script "$('##{options[:from]}').val('#{value}')"
    end

    def test_run_id
      @@test_run_id
    end

    private

    #Try not to use this!!! http://www.elabs.se/blog/53-why-wait_until-was-removed-from-capybara
    def wait_until
      require "timeout"
      Timeout.timeout(Capybara.default_wait_time) do
        sleep(0.1) until value = yield
        value
      end
    end
  end
end
require 'page/page_helper'

module Page

  module Pages
    @@pages = {}

    # Creates an instance variable and accessor method of the class passed in
    # eg
    # > Page::Pages::create_module_accessor_for_page Pages::ProfilePage
    # will create the module method
    # > Page::Pages::profile_page
    # that returns an instance of Pages::ProfilePage
    #
    # When Page::Pages is included in the spec_helper like this:
    # > config.include Page::Pages
    # it will make the method accessible globally within the specs so you can access a page like this:
    # > profile_page.go_to_page
    def self.create_module_accessor_for_page base
      name = base.name.split("::").last.underscore
      
      define_method name.to_sym do
        if @@pages[name] == nil
          @@pages[name] = base.new
        end
        @@pages[name]
      end
    end

    def self.clear
      @@pages = {}
    end
  end

  class Base
    
    include PageHelper

    def self.inherited(sub)
      Pages.create_module_accessor_for_page sub      
    end
  end
end
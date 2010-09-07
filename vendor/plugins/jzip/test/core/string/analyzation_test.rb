require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "test_helper.rb"))

module Jzip
  module Test
    module Core
      module String

        class AnalyzationTest < ActiveSupport::TestCase
          setup do
            include Setup
          end
          
          test "jzip_require_statement?" do
            assert_equal true , "//= require \"defaults\"".jzip_require_statement?
            assert_equal false, "//  require \"defaults\"".jzip_require_statement?
            assert_equal false, "#   require \"defaults\"".jzip_require_statement?
          end
      
          test "required_jzip_source" do
            # assert something
          end
      
          test "overrule_jzip_minification?" do
            # assert something
          end
        end
        
      end
    end 
  end
end
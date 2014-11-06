require 'test_helper'

class UserControllerTest < ActiveSupport::TestCase
   test "should create, find and save result" do
	 result=User.new
	 result.login='a'
	 result.password='a'
	 assert result.save
	 res=User.find_by_login('a')
	 assert_equal res.password, 'a'
	 res=User.find_by_login('v')
	 assert_equal nil, res
   end
   
   test "all fields must be filled" do
	 result=User.new
	 result.login='a'
	 assert !result.save
     result=User.new
	 result.password='asd'
	 assert !result.save
	 result=User.new
	 assert !result.save
   end
   
   test "all records myst have unique keys" do
	 result=User.new
	 result.login='a'
	 result.password='a'
	 assert result.save
	 result=User.new
	 result.login='a'
	 result.password='abc'
	 assert !result.save
   end
   
end

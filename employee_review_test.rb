require 'minitest/autorun'
require 'minitest/pride'
require 'byebug'
#Note: This line is going to fail first.
require './employee_require_list'

$mock_inputs = []
def get_user_input
  $mock_inputs.shift
end

class EmployeeReviewTest < Minitest::Test

  def test_classes_exist
    assert Employee
    assert Department
  end

  def test_department_can_be_named
    assert_equal "Human Resources", Department.new("Human Resources").name
  end

end

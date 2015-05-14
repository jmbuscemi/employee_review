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

  def test_employee_has_default_name_email_phone_number_salary
    assert_equal "John Doe", Employee.new.name
    assert_equal "none@email.com", Employee.new.email
    assert_equal "555-555-5555", Employee.new.phone_number
    assert_equal 50000, Employee.new.salary
  end

  # def test_create_employee_with_name
  #   assert_equal "Emily", Employee.new(name: "Emily").name
  # end
  #
  # def test_employee_has_email
  #   assert_equal ""
  # end

end

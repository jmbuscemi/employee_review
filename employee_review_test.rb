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

  def test_create_employee_with_name_phone_email_salary
    employee = Employee.new(name: "Emily", email: "emily@gmail.com",
                            phone_number: "919-123-4567", salary: 75000)
    assert_equal "Emily", employee.name
    assert_equal "emily@gmail.com", employee.email
    assert_equal "919-123-4567", employee.phone_number
    assert_equal 75000, employee.salary
  end

  def test_add_employee_to_department
    department = Department.new("Management")
    employee = Employee.new(name: "John")

    department.assign(employee)

    assert_equal [employee], department.employees
    assert_equal ["John"], department.employee_names
  end

  def test_add_multiple_employees_to_diff_departments
    mgmt_department = Department.new("Management")
    mgmt_employee1 = Employee.new(name: "John")
    mgmt_employee2 = Employee.new(name: "Bill")

    mgmt_department.assign(mgmt_employee1)
    mgmt_department.assign(mgmt_employee2)

    hr_department = Department.new("Human Resources")
    hr_employee1 = Employee.new(name: "Sally")
    hr_employee2 = Employee.new(name: "Jane", salary: 10000)

    hr_department.assign(hr_employee1)
    hr_department.assign(hr_employee2)

    assert_equal [mgmt_employee1, mgmt_employee2], mgmt_department.employees
    assert_equal ["John", "Bill"], mgmt_department.employee_names

    assert_equal [hr_employee1, hr_employee2], hr_department.employees
    assert_equal ["Sally", "Jane"], hr_department.employee_names
  end

  def test_get_employee_salary
    department = Department.new("Creative")
    department.assign(Employee.new(name: "Emily", email: "emily@gmail.com",
                            phone_number: "919-123-4567", salary: 75000))
    department.assign(Employee.new(name: "John", email: "john@gmail.com",
                            phone_number: "919-765-4321", salary: 50000))
    assert_equal 75000, department.employee_salaries[0]
    assert_equal 50000, department.employee_salaries[1]
    refute department.employee_salaries[2]
  end

  def test_get_employee_department_name
    department = Department.new("Creative")
    assert_equal "Creative", department.name
    refute department.name == "Human Resources"
  end

  def test_get_department_total_salary
    department = Department.new("Management")
    department.assign(Employee.new(name: "Kerry", salary: 165000))
    department.assign(Employee.new(name: "GP", salary: 105000))

    assert_equal (165000 + 105000), department.total_salary
  end

  
end

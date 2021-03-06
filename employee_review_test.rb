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

  def test_can_add_review_text_to_an_employee
    jose = Employee.new(name: "Jose")
    mike = Employee.new(name: "Mike")

    jose.add_review("Jose is a huge asset to SciMed and is a pleasure to work with.  He quickly knocks out tasks assigned to him, implements code that rarely needs to be revisited, and is always willing to help others despite his heavy workload.  When Jose leaves on vacation, everyone wishes he didn't have to go.
    Last year, the only concerns with Jose performance were around ownership.  In the past twelve months, he has successfully taken full ownership of both Acme and Bricks, Inc.  Aside from some false starts with estimates on Acme, clients are happy with his work and responsiveness, which is everything that his managers could ask for.")
    jose.add_review("Jose is a great boss")

    assert jose.review[0] == "Jose is a huge asset to SciMed and is a pleasure to work with.  He quickly knocks out tasks assigned to him, implements code that rarely needs to be revisited, and is always willing to help others despite his heavy workload.  When Jose leaves on vacation, everyone wishes he didn't have to go.
    Last year, the only concerns with Jose performance were around ownership.  In the past twelve months, he has successfully taken full ownership of both Acme and Bricks, Inc.  Aside from some false starts with estimates on Acme, clients are happy with his work and responsiveness, which is everything that his managers could ask for."
    refute mike.review[0] == "Mike used to drive a Sigma...can you believe it?!"
    assert jose.review.count == 2
  end

  def test_employee_has_performance_eval
    good_employee = Employee.new(evaluation: "Good")
    bad_employee = Employee.new(evaluation: "Bad")
    no_eval = Employee.new()

    assert good_employee.performance_eval
    refute bad_employee.performance_eval
    refute no_eval.performance_eval
  end

  def test_give_raise_to_employee
    employee = Employee.new()
    employee.give_raise(5000)

    assert_equal 55000, employee.salary

    employee = Employee.new()
    employee.give_raise(0.20)

    assert_equal 60000, employee.salary
  end

  def test_give_raises_to_good_employees_in_department
    department = Department.new("Creative")
    emily = Employee.new(name: "Emily", salary: 10000, evaluation: "Good")
    john = Employee.new(name: "John", salary: 10000, evaluation: "Good")
    ben = Employee.new(name: "Ben", salary: 10000, evaluation: "Bad")

    department.assign(emily)
    department.assign(john)
    department.assign(ben)

    department.give_raises(10000) {|employee| employee.performance_eval}

    assert_in_delta 15000, emily.salary, 0.01
    assert_in_delta 15000, john.salary, 0.01
    assert_in_delta 10000, ben.salary, 0.01
  end

  def test_give_raises_based_on_salary_requirement
    department = Department.new("Engineering")
    john = Employee.new(name: "John", salary: 85000)
    jose = Employee.new(name: "Jose", salary: 125000)
    mike = Employee.new(name: "Mike", salary: 88000)

    department.assign(john)
    department.assign(jose)
    department.assign(mike)

    department.give_raises(10000) {|employee| (employee.salary < 100000)}

    assert_in_delta 90000, john.salary, 0.01
    assert_in_delta 93000, mike.salary, 0.01
    assert_in_delta 125000, jose.salary, 0.01
  end



end

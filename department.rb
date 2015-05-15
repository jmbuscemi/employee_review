class Department
  attr_reader :name, :employees

  def initialize (name)
    @name = name
    @employees = []
  end

  def assign(employee)
    @employees << employee
  end

  def employee_names
    @employees.map {|e| e.name}
  end

  def employee_salaries
    @employees.map {|e| e.salary}
  end

  def total_salary
    employee_salaries.reduce(:+)
    #Research the .inject method to use here.
  end


end

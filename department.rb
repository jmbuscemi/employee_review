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
    #Research the .inject method to use here.
    employee_salaries.reduce(:+)
  end

  def give_raises (amount)
    raise_employees = @employees.select {|e| yield(e)}
    number_getting_raises = raise_employees.count.to_f
    raise_employees.each {|e| e.give_raise(amount / number_getting_raises)}
  end


end

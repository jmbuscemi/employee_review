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
    @employees.map {|n| n.name}
  end

end

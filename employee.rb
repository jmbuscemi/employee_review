class Employee
  attr_reader :name, :email, :phone_number, :salary

  def initialize (name: "John Doe", email: "none@email.com",
                  phone_number: "555-555-5555", salary: 50000)
    @name = name
    @email = email
    @phone_number = phone_number
    @salary = salary
  end

end

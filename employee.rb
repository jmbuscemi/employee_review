class Employee
  attr_reader :name, :email, :phone_number, :salary, :review

  def initialize (name: "John Doe", email: "none@email.com",
                  phone_number: "555-555-5555", salary: 50000,
                  evaluation: "")
    @name = name
    @email = email
    @phone_number = phone_number
    @salary = salary
    @review = []
    @evaluation = evaluation
  end

  def add_review(review)
    @review << review
  end

  def performance_eval
    true if @evaluation == "Good"
  end

end

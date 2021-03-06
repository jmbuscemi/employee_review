# Employee Reviews

## Description

This pogram tracks employees and their departments.

#Features
#### Part 1

In order to keep track of employees (with their names, email addresses, phone numbers, and salaries), departments (with their names), and which employees are in which department - this program:

* Creates a new department (given its name).
* Creates a new employee (given his/her name, email address, phone number, and salary).
* Add an employee to a department.
* Get an employee's name.
* Get an employee's salary.
* Get a department's name.
* Get a total salary for all employees in a department.
* Add some employee review text (a paragraph or two) to an employee.
* Mark whether an employee is performing satisfactorily or not satisfactorily.
* Give a raise to an individual. Raise percentage or amount can be entered.
* Give raises to a department's employees. A total raise amount for the department is passed to this method. The method distributes the raise amounts evenly to the department's employees who are performing satisfactorily.

#### Part 2
The program can take a block which will specify which employees are eligible for raises. For example, if a department had $5,000 to spread out to its employees in raises, but you wanted to only give raises to people who only made less than $100,000, you could call a `give_raises` method like this:

    department.give_raises(5000) do |employee|
      employee.salary < 100000
    end

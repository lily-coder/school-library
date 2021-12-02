require './corrector'
require './rental'

class Person
  attr_reader :id
  attr_accessor :name, :age, :rental

  def initialize(age, name = 'Unknown', parent_permission = true)
    @corrector = Corrector.new()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rental = []
  end

  def validate_name
    @name = @corrector.correct_name(@name)
  end

  def can_use_services?
    is_of_age? || @parent_permission
  end

  private

  def is_of_age?
    @age >= 18
  end

  def add_rental(date, book)
    Rental.new(date, self, book)
  end

end

require './rental'

class Book
  attr_accessor :title, :author, :rental

  def initialize(title, author)
    @title = title
    @author = author
    @rental = []
  end

  def include_rental(person, date)
    Rental.new(person, self, date)
  end
end

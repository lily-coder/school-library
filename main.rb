require './person'
require './book'
require './rental'
require './teacher'
require './classroom'
require './student'

class App
  def initialize
    @rental = []
    @books = []
    @people = []
  end

  def main
    app = App.new
    app.main
    reply = nil
    puts "Welcome to our App!\n\n"
    while reply != '7'
      puts 'Please choose an option by enterin a number:'
      puts '1 - List all books'
      puts '2 - List all people'
      puts '3 - Create a person'
      puts '4 - Create a book'
      puts '5 - Create a rental'
      puts '6 - List all rentals for a given person id'
      puts '7 - Exit'
      reply = gets.chomp
      case reply
      when '1'
        app.list_books
      when '2'
        app.list_people
      when '3'
        app.create_person
      when '4'
        app.create_book
      when '5'
        app.create_rental
      when '6'
        app.list_rentals_for_person_id
      when '7'
        puts 'Thank you for using this app!'
      end
      puts "\n"
    end
  end

  def list_books
    @books.each do |book|
      puts "Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_people
    @people.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp
    if person_type != '1' && person_type != '2'
      puts 'Invalid option'
      return
    end
    print 'Your Age: '
    age = gets.chomp
    print 'Your Name: '
    name = gets.chomp
    person =
      case person_type
      when '1'
        print 'Do you have parent permission? [Y/N]: '
        parent_permission = gets.chomp
        parent_permission = parent_permission.downcase == 'y'
        Student.new(age, name, parent_permission)
      when '2'
        print 'Specialization: '
        specialization = gets.chomp

        Teacher.new(age, specialization, name)
      end

    @people << person
    puts 'Person created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book_index = gets.chomp.to_i

    puts "\nSelect a person by number (not id)"
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i

    print "\nDate: "
    date = gets.chomp

    @rental << Rental.new(date, @books[book_index], @people[person_index])
    puts 'Rental created successfully'
  end

  def list_rentals_for_person_id
    print 'ID of person: '
    id = gets.chomp.to_i

    rental = @rental.filter { |_rental| rental.person.id == id }
    puts 'Rental:'
    rental.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end
  puts 'Thank you for using the app'
end

main

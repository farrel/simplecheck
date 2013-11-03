require 'date'
require 'simplecheck'

class Person
  include Simplecheck
  include Comparable

  attr_accessor( :name, :surname, :date_of_birth )

  def initialize( name, surname, date_of_birth )
    check( name, surname, String )
    check( date_of_birth, Date )

    @name          = name
    @surname       = surname
    @date_of_birth = date_of_birth
  end

  def <=>( person )
    check( person, Person )
    check( person.date_of_birth )

    self.date_of_birth <=> person.date_of_birth
  end
end

def try
  begin
    yield
  rescue Simplecheck::CheckFailed => exception
    puts "Check Failed: #{ exception.message }"
  rescue => exception
    puts "EXCEPTION: #{ exception.message }"
  end
end

# date_of_birth is not a Date
try{ Person.new( 'Bob', 'Roberts', '1980-01-01' )} 

bob = Person.new( 'Bob', 'Roberts', Date.civil( 1970, 1, 1 )) 
joe = Person.new( 'Joe', 'Josephs', Date.civil( 1980, 1, 1 ))

# 1 is not a Person
try{ bob > 1 }

if joe > bob
  puts "Joe > Bob"
end

bob.date_of_birth = nil

# date_of_birth is not present
try{ joe > bob }

require 'date'
require 'simplecheck'

class Person
  include Simplecheck
  include Comparable

  attr_reader( :name, :surname, :date_of_birth )

  def initialize( name, surname, date_of_birth )
    check( name, surname, String )
    check( date_of_birth, Date )

    @name          = name
    @surname       = surname
    @date_of_birth = date_of_birth
  end

  def <=>( person )
    check( person, Person )

    comparison = lambda{ |o| [ o.date_of_birth, o.surname, o.name ]}

    comparison[ self ] <=> comparison[ person ]
  end
end

def try
  begin
    yield
  rescue Simplecheck::CheckFailed => exception
    puts "Check Failed: #{ exception.message }"
  end
end

try{ Person.new( 'Bob', 'Roberts', '1980-01-01' )}

bob = Person.new( 'Bob', 'Roberts', Date.civil( 1980, 1, 1 )) 
joe = Person.new( 'Joe', 'Josephs', Date.civil( 1980, 1, 1 ))

try{ bob > 1 }

puts "Bob > Joe" if bob > joe 

require 'simplecheck'
require 'date'

class Person
  include Simplecheck

  def initialize( name, surname, id_number )
    check( name, surname, String ) # Name and Surname must be Strings
    check( id_number, /^[\d]{16}$/ ) # ID Number must be a 16 digit String
  end
end

def check_person( *arguments )
  Person.new( *arguments ) 
rescue Simplecheck::CheckFailed => exception
  puts "Simplecheck exception: #{ exception.message }"
rescue => exception
  puts "Non Simplecheck exception: #{ exception.message }"
else
  puts "No check failures"
end

check_person( "Name", nil, "1234567890123456" )      # No Surname
check_person( "Name", "Surname", "123456789012345" ) # ID Number is too short
check_person( "Name", "Surname" )                    # Too few arguments - Non Simplecheck exception

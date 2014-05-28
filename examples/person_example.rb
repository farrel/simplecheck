require 'date'
require 'simplecheck'

class Person
  include Simplecheck
  include Comparable

  attr_accessor :name, :surname, :date_of_birth 

  def initialize(name, surname, date_of_birth)
    check name, surname, String
    check date_of_birth, Date

    @name          = name
    @surname       = surname
    @date_of_birth = date_of_birth
  end

  def <=>(other)
    check other, Person
    check other.date_of_birth

    date_of_birth <=> other.date_of_birth
  end
end

def try
  yield
rescue Simplecheck::CheckFailed => exception
  puts "Simplecheck::CheckFailed: #{ exception.message }"
end

# date_of_birth is not a Date
try { Person.new('Bob', 'Roberts', '1980-01-01') }

bob = Person.new('Bob', 'Roberts', Date.civil(1970, 1, 1))
joe = Person.new('Joe', 'Josephs', Date.civil(1980, 1, 1))

# 1 is not a Person
try { bob > 1 }

puts 'Joe > Bob' if joe > bob

bob.date_of_birth = nil

# date_of_birth is not present
try { joe > bob }

puts 'Finished'

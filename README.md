# Simplecheck

Simplecheck is a lightweight property checking API for Ruby designed to quickly check arguments in under 50 lines of Ruby. Once included into a class it provides the `check` instance method which takes arguments and a condition to check them against.

If a check fails a `Simplecheck::CheckFailed` exception is raised.

Simplecheck is compatiable with Ruby 2.0.0 and above only.

## Installation

Simplecheck is available as a Rubygem installable via [gem install simplecheck](http://rubygems.org/gems/simplecheck).

A git repository is also available at [http://github.com/farrel/simplecheck](http://github.com/farrel/simplecheck).

## Usage

    require 'simplecheck'

    class Customer
      include Simplecheck
      
      attr_accessor(:name, :age)

      def initialize(name, age)
        check(name, String, error_message: 'name must be a String') # Check name is String with custom error message
        check(age, 18..75)                                          # Check age is within Range
    
        @name, @age = name, age
      end
    end
    
    Customer.new("Joe", 25) # No error

    begin
      Customer.new(nil, 25)
    rescue Simplecheck::CheckFailed => exception
      puts exception.message # => 'name must be a String'  
    ebd

    begin 
      Customer.new("Joe", 15) 
    rescue Simplecheck::CheckFailed => exception
      puts exception.message # => '15 does not satisfy 18..75'
    ebd

## Check Methods

Simplecheck currently supports three different check methods:

* Expression Check
* Case Equality (===) Check 
* Block Check

### Custom Error Message

All check methods may take an optional named parameter `error_message` to override the default error message.

    check(age, Integer, error_message: 'Age must be a whole number')

### Expression Check

In the simplest case `check` takes an expression as an argument. If the expression evaluates to `nil` or `false` it will fail. 

    def calculate_percentage(score, total)
      check(total > 0, error_message: 'Total must be a positive number')
      100.0 * score / total
    end

### Case Equality (===) Check

If two or more arguments are given without a block, then the last argument becomes the condition against which the previous arguments are checked. To accomplish this the condition argument should implement the case equality operator (`===` or threequal) in a logical manner.

    def greatest_common_divisor(a, b)
      check(a, b, Integer)
      # GCD Algorithm...
    end

If a class does not alias or implement it's own version of `===` it has the same functionality as  `==`. The following Ruby Core classes already alias `===` to various instance methods.

#### Class

`===` is aliased to `kind_of?`:

    check(age, Numeric)

#### Range

`===` is aliased to `include?`:

    check(age, 18..75) 

#### Regexp

`===` is aliased to `=~`:

    check(phone_number, /^\d\d\d-\d\d\d\d$/, error_message: 'Phone number format is not valid')

#### Proc

`===` is aliased to `call`: 

    check(password, password_confirmation , ->(p) { !Dict.lookup(p) })

#### Custom Check Object

The default behaviour of `Object#===` is the same as `Object#==`. To customise the behaviour implement your own `Object#===` method.

For example to check whether a set of points is inside a given polygon we would implement `Polygon#===` as a [point-in-polygon algorithm](https://en.wikipedia.org/wiki/Point_in_polygon), allowing us to carry out the check using a Polygon instance:

    check(point_1, point_2, polygon)

### Block Check

A block can be passed to `check`, with the arguments passed to `check` then passed individually to the block:

    check(a, b, c) do |n|
      n.odd?
    end

This is syntactic sugar for the Proc Case Equality check.

## Multiple Arguments

Case Equality and Block checks can be called with multiple arguments, with each argument being checked individually against the condition:

    check(i, j, k, Integer) 
    check(a, b, c) do |n|
      n.even?
    end

## Resources

* Git repository - [http://github.com/farrel/simplecheck](http://github.com/farrel/simplecheck)
* Rubygem page - [http://rubygems.org/gems/simplecheck](http://rubygems.org/gems/simplecheck)

Simplecheck
===========

Simplecheck is a property checking API for Ruby designed for quickly checking arguments. Once included into a class it provides the `check` instance method which takes a list of arguments and a condition to check them against.

If a check fails an exception of type `Simplecheck::CheckFailed` is raised.

Usage
-----

    require 'simplecheck'

    class Person
      include Simplecheck

      def initialize( name, age )
        check( name )
        check( age, 18..75 )
    
        @name = name
        @age = age
      end
    end
    
    Person.new( "Joe", 25 ) # No error
    Person.new( nil, 25 ) rescue puts "Name can not be nil"
    Person.new( "Joe", 15 ) rescue puts "Age is out of range"

Check Methods
-------------

Simplecheck currently supports three different check methods:

* Expression Check
* Case Equality (===) Check 
* Block Check

#### Multiple Arguments

Case Equality and Block checks can be called with multiple arguments, with each argument being checked individually against the condition:

    check( name, surname, String )

### Expression Check

In the simplest case `check` takes an expression as an argument. If the expression evaluates to `nil` or `false` it will fail.

    check( a > 2 )

### Case Equality (===) Check

If two or more arguments are given without a block, then the last argument becomes the condition against which the previous arguments are checked. To accomplish this the condition argument should implement the case equality operator (`===` or threequal) in a logical manner.

If a class does not alias or implement it's own version of `===` it has the same functionality as  `==`. The following Ruby Core classes already alias `===` to various instance methods. If a class does not alias or implement it's own version of `===` it has the same functionality as  `==`.

#### Class

`===` is aliased to `kind_of?`:

    check( age, Numeric )

#### Range

`===` is aliased to `include?`:

    check( age, 18..75 ) 

#### Regexp

`===` is aliased to `match`:

    check( phone_number, /^\d\d\d-\d\d\d\d$/ )

#### Proc

`===` is aliased to `call`: 

    check( password, password_confirmation, lambda{ |pwd| !Dictionary.check( pwd )})

#### Custom Check Object

The default behaviour of `Object#===` is the same as `Object#==`. To customise the behaviour implement your own `Object#===`.

For example to check whether a set of points is inside a given polygon we would implement `Polygon#===` as a [point-in-polygon algorithm](https://en.wikipedia.org/wiki/Point_in_polygon), allowing us to carry out the check using a Polygon instance:

    check( point_1, point_2, polygon )

### Block Check

A block can be passed to `check`, with the arguments passed to `check` then passed individually to the block.:

    check( a, b, c ) do |n|
      n.modulo?(2).zero?
    end

This is syntactic sugar for the Proc Case Equality check.

License
-------
Simplecheck is released under the BSD License.

Copyright 2013 AIMRED CC. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY AIMRED CC "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL AIMRED CC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies, either expressed or implied, of AIMRED CC.

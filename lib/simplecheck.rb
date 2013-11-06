require 'simplecheck/version'
require 'simplecheck/check_failed'

module Simplecheck
  def check( *arguments, &block )
    error_message = if block_given?
                      Simplecheck.check_arguments_with_block( arguments, block )
                    else
                      Simplecheck.check_arguments( arguments )
                    end

    error_message ?  Simplecheck.handle_failure( error_message ) : true
  end

  def Simplecheck.check_arguments( arguments )
    case arguments.size
    when 1
      Simplecheck.check_expression( arguments[ 0 ])
    else
      Simplecheck.check_case_equality( *arguments )
    end
  end

  def Simplecheck.check_arguments_with_block( arguments, block )
    Simplecheck.check_arguments(( arguments + [ block ]))
  end

  def Simplecheck.check_expression( expression )
    if !expression
      'Condition is not satisfied' 
    end
  end

  def Simplecheck.check_case_equality( *arguments, check_argument )
    if invalid_argument = arguments.find{ |argument| !( check_argument === argument )}
      "#{ invalid_argument } does not satisfy #{ check_argument }" 
    end
  end

  def Simplecheck.handle_failure( message )
    raise Simplecheck::CheckFailed.new( message )
  end
end

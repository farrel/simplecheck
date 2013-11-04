require 'simplecheck/version'
require 'simplecheck/check_failed'

module Simplecheck
  def check( *arguments, &block )
    error_message = if block_given?
                      simplecheck_check_arguments_with_block( arguments, block )
                    else
                      simplecheck_check_arguments( arguments )
                    end

    if error_message
      simplecheck_handle_failure( error_message )
    else
      simplecheck_handle_return_arguments( arguments )
    end
  end


  private
  def simplecheck_check_arguments( arguments )
    case arguments.size
    when 1
      simplecheck_check_expression( arguments[ 0 ])
    else
      simplecheck_check_case_equality( *arguments )
    end
  end

  def simplecheck_check_arguments_with_block( arguments, block )
    simplecheck_check_arguments(( arguments + [ block ]))
  end

  def simplecheck_check_expression( expression )
    if !expression
      'Condition is not true' 
    end
  end

  def simplecheck_check_case_equality( *arguments, receiver )
    if invalid_argument = arguments.find{ |argument| !( receiver === argument )}
      "#{ invalid_argument } does not satisfy #{ receiver }" 
    end
  end

  def simplecheck_handle_failure( message )
    raise Simplecheck::CheckFailed.new( message )
  end

  def simplecheck_handle_return_arguments( arguments )
    case arguments.size
    when 1
      arguments[0]
    else
      arguments
    end
  end
end

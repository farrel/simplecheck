require 'simplecheck/version'
require 'simplecheck/check_failed'

module Simplecheck
  def check( *arguments, &block )
    error_message = if block_given?
                      __check_arguments_with_block( arguments, block )
                    else
                      __check_arguments( arguments )
                    end

    if error_message
      __handle_failure( error_message )
    else
      __handle_return_arguments( arguments )
    end
  end


  private
  def __check_arguments( arguments )
    case arguments.size
    when 1
      __check_expression( arguments[ 0 ])
    else
      __check_case_equality( *arguments )
    end
  end

  def __check_arguments_with_block( arguments, block )
    __check_arguments(( arguments + [ block ]))
  end

  def __check_expression( expression )
    if !expression
      'Condition is not true' 
    end
  end

  def __check_case_equality( *arguments, receiver )
    if invalid_argument = arguments.find{ |argument| !( receiver === argument )}
      "#{ invalid_argument } does not satisfy #{ receiver }" 
    end
  end

  def __handle_failure( message )
    raise Simplecheck::CheckFailed.new( message )
  end

  def __handle_return_arguments( arguments )
    case arguments.size
    when 1
      arguments[0]
    else
      arguments
    end
  end
end

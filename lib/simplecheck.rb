require 'simplecheck/version'
require 'simplecheck/check_failed'

module Simplecheck
  def check( *arguments, &block )
    check_passed, message = if block
                              check_block( block, *arguments )
                            else
                              check_arguments( *arguments )
                            end

    if check_passed
      true
    else
      handle_failure( message )
    end
  end

  private
  def check_block( block, *arguments )
    block.call( *arguments )
  end

  def check_arguments( *arguments )
    case arguments.size
    when 1
      check_bool( arguments[ 0 ] )
    else
      check_threequal( *arguments )
    end
  end

  def check_bool( condition )
    if condition 
      [ true, nil ] 
    else
      [ false, 'Condition is not true' ]
    end
  end

  def check_threequal( *arguments, receiver )
    if invalid_argument = arguments.find{ |argument| !( receiver === argument )}
      [ false, "#{ invalid_argument } does not satisfy #{ receiver }" ]
    else
      [ true, nil ] 
    end
  end

  def handle_failure( message )
    raise Simplecheck::CheckFailed.new( message )
  end
end

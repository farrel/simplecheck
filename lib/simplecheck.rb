require 'simplecheck/version'
require 'simplecheck/check_failed'

module Simplecheck
  def check(*arguments, &block)
    error_message = if block_given?
                      Simplecheck.check_arguments_with_block(arguments, block)
                    else
                      Simplecheck.check_arguments(arguments)
                    end

    error_message ?  Simplecheck.handle_failure(error_message) : true
  end

  def self.check_arguments(arguments)
    case arguments.size
    when 1
      check_expression(arguments[0])
    else
      check_case_equality(*arguments)
    end
  end

  def self.check_arguments_with_block(arguments, block)
    check_arguments(arguments + [block])
  end

  def self.check_expression(expression_satisfied)
    'Condition is not satisfied' unless expression_satisfied
  end

  def self.check_case_equality(*arguments, check_argument)
    invalid_argument_index = arguments.index{ |argument| !(check_argument === argument) }

    if invalid_argument_index
      "#{ arguments[invalid_argument_index] } does not satisfy #{ check_argument }"
    end
  end

  def self.handle_failure(message)
    fail(Simplecheck::CheckFailed, message)
  end
end

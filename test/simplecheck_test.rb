require 'test_helper'

class TestSimplecheck < MiniTest::Test
  include Simplecheck

  def test_expression_check_true
    assert(check(1))
  end

  def test_expression_check_raises_exception
    assert_raises(Simplecheck::CheckFailed) { check(nil) }
  end

  def test_expression_check_raises_exception_with_error_message
    exception = assert_raises(Simplecheck::CheckFailed) { check(nil, error_message: 'Nil object') }
    assert_equal(exception.message, 'Nil object')
  end

  def test_case_equality_check_true
    assert(check(1, Integer))
  end

  def test_case_equality_check_raises_exception
    assert_raises(Simplecheck::CheckFailed) { check('1', Integer) }
  end

  def test_case_equality_check_raises_exception_with_error_message
    exception = assert_raises(Simplecheck::CheckFailed) { check('1', Integer, error_message: 'Not Integer') }
    assert_equal(exception.message, 'Not Integer')
  end

  def test_case_equality_check_multiple_arguments
    assert(check(1, 2, Integer))
  end

  def test_case_equality_check_multiple_arguments_raises_exception
    assert_raises(Simplecheck::CheckFailed) { check(1, '2', Integer) }
  end

  def test_case_equality_check_multiple_arguments_raises_exception_with_error_message
    exception = assert_raises(Simplecheck::CheckFailed) { check(1, '2', Integer, error_message: 'Not Integer') }
    assert_equal(exception.message, 'Not Integer')
  end

  def test_block_check_true
    assert(check(1) { |n| n.odd? })
  end

  def test_block_check_raises_exception
    assert_raises(Simplecheck::CheckFailed) { check(1) { |n| n.even? } }
  end

  def test_block_check_raises_exception_with_error_message
    exception = assert_raises(Simplecheck::CheckFailed) { check(1, error_message: 'Not Even') { |n| n.even? } }
    assert_equal(exception.message, 'Not Even')
  end

  def test_block_check_multiple_arguments_true
    assert(check(1, 1, 1) { |n| n.odd? })
  end

  def test_block_check_multiple_arguments_exception
    assert_raises(Simplecheck::CheckFailed) { check(1, 1, 2) { |n| n.odd? } }
  end

  def test_block_check_multiple_arguments_exception_with_error_message
    exception = assert_raises(Simplecheck::CheckFailed) { check(1, 1, 2, error_message: 'Not Odd') { |n| n.odd? } }
    assert_equal(exception.message, 'Not Odd')
  end

  def test_lambda_argument_check_true
    assert(check(1, ->(n) { n.odd? }))
  end

  def test_lambda_argument_check_raises_exception
    assert_raises(Simplecheck::CheckFailed) { check(1, ->(n) { n.even? }) }
  end

  def test_lambda_argument_check_raises_exception_with_error_message
    exception = assert_raises(Simplecheck::CheckFailed) { check(1, ->(n) { n.even? }, error_message: 'Not Even') }
    assert_equal(exception.message, 'Not Even')
  end

  def test_lambda_block_check_true
    assert(check(1, &->(n){ n.odd? }))
  end

  def test_lambda_block_check_raises_exception
    assert_raises(Simplecheck::CheckFailed) { check(1, &->(n){ n.even? }) }
  end

  def test_lambda_block_check_raises_exception_with_error_message
    exception = assert_raises(Simplecheck::CheckFailed) { check(1, error_message: 'Not Even', &->(n){ n.even? }) }
    assert_equal(exception.message, 'Not Even')
  end

  def test_nil_check
    assert_raises(Simplecheck::CheckFailed) { check(nil, String) }
  end
end

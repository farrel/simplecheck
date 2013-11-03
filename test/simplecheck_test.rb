require 'test_helper'

class Foo
  include Simplecheck

  def expression_check( a )
    check( a )
  end

  def case_equality_check( a )
    check( a, Integer )
  end

  def case_equality_check_multiple_arguments( *arguments )
    check( *arguments, Integer )
  end

  def block_check( a )
    check( a ){ |x| x.modulo( 2 ).zero? }
  end

  def block_check_multiple_arguments( a, b, c )
    check( a, b, c ){ |x| x.even? }
  end

  def lambda_argument_check( a )
    check_lambda = lambda{ |x| x.even? }
    check( a, check_lambda ) 
  end

  def lambda_block_check( a )
    check_lambda = lambda{ |x| x.even? }
    check( a, &check_lambda ) 
  end
end

class TestSimplecheck < MiniTest::Test

  def setup
    @foo = Foo.new
  end

  def test_expression_check_true
    assert( @foo.expression_check( 1 ))
  end

  def test_expression_check_raises_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.expression_check( nil )}
  end

  def test_case_equality_check_true
    assert( @foo.case_equality_check( 1 ))
  end

  def test_case_equality_check_raises_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.case_equality_check( '1' )}
  end

  def test_case_equality_check_multiple_arguments
    assert( @foo.case_equality_check_multiple_arguments( 1, 2 ))
  end

  def test_case_equality_check_multiple_arguments_raises_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.case_equality_check_multiple_arguments( 1, '2' )}
  end

  def test_block_check_true
    assert( @foo.block_check( 2 )) 
  end

  def test_block_check_raises_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.block_check( 1 )}
  end

  def test_block_check_multiple_arguments_true
    assert( @foo.block_check_multiple_arguments( 2, 2, 2 ))
  end

  def test_block_check_multiple_arguments_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.block_check_multiple_arguments( 2, 2, 1 )}
  end

  def test_lambda_argument_check_true
    assert( @foo.lambda_argument_check( 2 ))
  end

  def test_lambda_argument_check_raises_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.lambda_argument_check( 1 )}
  end

  def test_lambda_block_check_true
    assert( @foo.lambda_block_check( 2 ))
  end

  def test_lambda_block_check_raises_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.lambda_block_check( 1 )}
  end
end

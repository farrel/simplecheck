require 'minitest/autorun'
require 'simplecheck'

class Foo
  include Simplecheck

  def bool_check( a )
    check( a > 0 )
  end

  def threequel_check( a )
    check( a, Integer )
  end

  def multiple_threequal_check( *arguments )
    check( *arguments, Integer )
  end

  def block_check( a )
    check( a ){ |x| x.modulo( 2 ).zero? }
  end

  def block_check_multiple_arguments( a, b, c )
    check( a, b, c ){ |x, y, z| ( x + y + z ).even? }
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

class TestSimplecheck < MiniTest::Unit::TestCase

  def setup
    @foo = Foo.new
  end

  def test_bool_check_true
    assert( @foo.bool_check( 1 ))
  end

  def test_bool_check_raises_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.bool_check( -1 )}
  end

  def test_threequal_check_true
    assert( @foo.threequel_check( 1 ))
  end

  def test_threequal_check_raises_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.threequel_check( '1' )}
  end

  def test_multiple_threequal_check
    assert( @foo.multiple_threequal_check( 1, 2 ))
  end

  def test_multiple_threequal_check_raises_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.multiple_threequal_check( 1, '2' )}
  end

  def test_block_check_true
    assert( @foo.block_check( 2 )) 
  end

  def test_block_check_raises_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.block_check( 1 )}
  end

  def test_block_check_multiple_arguments_true
    assert( @foo.block_check_multiple_arguments( 1, 2, 1 ))
  end

  def test_block_check_multiple_arguments_exception
    assert_raises( Simplecheck::CheckFailed ){ @foo.block_check_multiple_arguments( 1, 2, 2 )}
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

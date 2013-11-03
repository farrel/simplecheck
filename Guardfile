# A sample Guardfile
# More info at https://github.com/guard/guard#readme

notification( :terminal_title )

guard( :minitest, include: [ 'lib' ]) do
  watch( 'test/simplecheck_test.rb' )
  watch( 'lib/simplecheck.rb' ){ 'test/simplecheck_test.rb' }
end

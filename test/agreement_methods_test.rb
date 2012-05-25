require 'test_helper'

class AgreementMethodsTest < Test::Unit::TestCase
  def setup
    @key = 'key'
    @guide = Guide.new
  end
  
  def test_agree
    @guide.agree @key
    assert_equal @key, @guide.agreement._id
  end
  
  def test_confirm
    @guide.agree @key
    @guide.confirm @key
    assert_equal [@key], @guide.agreement.confirmations
  end  
end
require 'test_helper'

class AnatomyMethodsTest < Test::Unit::TestCase
  def setup
    @key = 'key'
    @guide = Guide.new
  end
  
  def test_new_anatomy
    anatomy = @guide.new_anatomy :_id => @key
    assert_equal @key, anatomy._id
  end
  
  def test_body
    @guide.receiver = @guide
    anatomy = @guide.body @key, @key, @key
    assert_equal anatomy, @guide.anatomy
    assert_equal @key, anatomy._id
    assert_equal @key, anatomy.explanation    
    assert_equal @key, anatomy.image
  end  
end
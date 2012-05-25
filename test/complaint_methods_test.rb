require 'test_helper'

class ComplaintMethodsTest < Test::Unit::TestCase
  def setup
    @key = 'key'
    @guide = Guide.new
  end
  
  def test_new_complaint
    complaint = @guide.new_complaint :_id => @key
    assert_equal @key, complaint._id
  end
  
  def test_complain
    @guide.complain @key do
      assert_equal @guide.complaints.first, @guide.receiver
    end
    assert_equal @guide, @guide.receiver
  end
  
  def test_complaint_explanation
    @guide.receiver = @guide.new_complaint(:_id => @key)
    @guide.complaint_explanation @key
    assert_equal @key, @guide.receiver.description
  end
end
require 'test_helper'

class QuestionMethodsTest < Test::Unit::TestCase
  def setup
    @key = 'key'
    @guide = Guide.new
  end
  
  def test_new_question
    question = @guide.new_question :_id => @key
    assert_equal @key, question._id
  end
  
  def test_question
    reply_type = 'pick_one'
    group = Group.new
    @guide.receiver = group
    
    @guide.question @key, reply_type do
      assert_equal group.questions.first, @guide.receiver
    end
    assert_equal group, @guide.receiver
  end
  
  def test_question_explanation
    @guide.receiver = @guide.new_question(:_id => @key)
    @guide.question_explanation @key
    assert_equal @key, @guide.receiver.explanation
  end
  
  def test_question_warning
    @guide.receiver = @guide.new_question(:_id => @key)
    @guide.question_warning @key
    assert_equal @key, @guide.receiver.alerts.first._id
  end  
  
  def test_required
    @guide.receiver = @guide.new_question(:_id => @key)
    @guide.required
    assert_equal true, @guide.receiver.required    
  end
end
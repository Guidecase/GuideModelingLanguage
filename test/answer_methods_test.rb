require 'test_helper'

class AnswerMethodsTest < Test::Unit::TestCase
  def setup
    @key = 'key'
    @guide = Guide.new
  end
  
  def test_new_answer
    answer = @guide.new_answer :_id => @key
    assert_equal @key, answer._id
  end
  
  def test_answer
    question = Question.new
    @guide.receiver = question
    
    @guide.answer @key do
      assert_equal question.answers.first, @guide.receiver
    end
    assert_equal question, @guide.receiver
  end
  
  def test_answer_explanation
    @guide.receiver = @guide.new_answer(:_id => @key)
    @guide.answer_explanation @key
    assert_equal @key, @guide.receiver.explanation
  end
end
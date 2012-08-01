require 'test_helper'

class GuideTest < Test::Unit::TestCase
  def setup
    @guide = Guide.new
  end
  
  def test_questions
    @guide.groups << first = Group.new(:id => 'first', :questions => [Question.new])
    @guide.groups << second = Group.new(:id => 'second', :questions => [Question.new])
    assert_equal first.questions + second.questions, @guide.questions
  end  
  
  def test_questions_group
    @guide.groups << first = Group.new(:id => 'first', :questions => [Question.new])
    @guide.groups << second = Group.new(:id => 'second', :questions => [Question.new])
    assert_equal first.questions, @guide.questions('first')    
  end  
end
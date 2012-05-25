require 'test_helper'

class GuideModelingLanguageTest < Test::Unit::TestCase
  def setup
    @key = 'key'
    @guide = Guide.new
  end
  
  def test_define
    @guide.define @key do
      assert_equal @key, @guide.slug, "should assign slug key"
      assert_equal @guide, @guide.receiver, "should assign self as initial receiver"
    end
  end
  
  def test_version_number
    @guide.version_number '101.2'
    assert_equal '101.2', @guide.version
  end
  
  def test_warning_with_question
    question = Question.new
    @guide.receiver = question
    
    assert_nothing_thrown do
      @guide.warning @key
    end
  end  
  
  def test_description_with_guide
    @guide.description @key
    assert_equal @key.to_s, @guide.summary
  end

  def test_description_with_diagnosis
    diagnosis = Diagnosis.new
    @guide.receiver = diagnosis
    
    assert_nothing_thrown do
      @guide.description @key
    end
  end
  
  def test_group
    assert_equal 0, @guide.groups.size
    @guide.group @key do
      assert_equal 1, @guide.groups.size
      assert_equal @guide.groups.last, @guide.receiver
    end 
  end
  
  def test_illustration
   @guide.receiver = Question.new
   @guide.illustration @key
   assert_equal @key, @guide.receiver.image
  end 
  
  def test_explanation_with_question
    @guide.receiver = Question.new
    
    assert_nothing_thrown do
      @guide.explanation @key
    end
    assert_equal @key, @guide.receiver.explanation
  end
  
  def test_explanation_with_answer
    @guide.receiver = Answer.new
    
    assert_nothing_thrown do
      @guide.explanation @key
    end
    assert_equal @key, @guide.receiver.explanation
  end
  
  def test_explanation_with_complaint
    @guide.receiver = Complaint.new
    
    assert_nothing_thrown do
      @guide.explanation @key
    end
    assert_equal @key, @guide.receiver.description
  end   
  
  def test_given
    outcome = Outcome.new
    @guide.receiver = outcome
    assert_equal 0, outcome.conditions.size
    @guide.given :one, :two
    assert_equal 1, outcome.conditions.size
    
    assert_equal :one, @guide.receiver.conditions.first.answers.first
    assert_equal :two, @guide.receiver.conditions.first.answers.last    
  end
end
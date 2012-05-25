require 'test_helper'

class OutcomeMethodsTest < Test::Unit::TestCase
  def setup
    @key = 'key'
    @guide = Guide.new
  end
  
  def test_new_outcome
    outcome = @guide.new_outcome :_id => @key
    assert_equal @key, outcome._id
  end  
  
  def test_outcome
    @guide.receiver = @guide
    
    assert_nothing_thrown do
      @guide.outcome @key
    end
    assert_equal 1, @guide.outcomes.first.urgency
    assert_equal @guide, @guide.receiver
  end
  
  def test_indicator
    outcome = Outcome.new
    @guide.receiver = outcome
    @guide.indicator @key
    assert_equal [@key], outcome.indicators
  end
  
  def test_recommend
    outcome = Outcome.new
    @guide.receiver = outcome
    @guide.recommend @key
    assert_equal @key, outcome.recommendation
  end
  
  def test_sick_days
    outcome = Outcome.new
    @guide.receiver = outcome
    @guide.sick_days 5
    assert_equal 5, outcome.sick_days
  end  
end
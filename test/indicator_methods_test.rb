require 'test_helper'

class IndicatorMethodsTest < Test::Unit::TestCase
  def setup
    @key = 'key'
    @guide = Guide.new
    @outcome = Outcome.new
    @guide.receiver = @outcome
  end

  def test_indicator
    @guide.indicator @key
    assert_equal 1, @outcome.indicators.size
    assert_equal @key, @outcome.indicators.first._id
  end  

  def test_indicator_conditions
  	condition = 'condition'

    @guide.indicator @key do |guide|
      guide.given condition
    end
    assert_equal 1, @outcome.indicators.size
    assert_equal condition, @outcome.indicators.first.conditions.first.answers.first
  end
end
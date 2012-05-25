require 'test_helper'

class DiagnosisMethodsTest < Test::Unit::TestCase
  def setup
    @key = 'key'
    @guide = Guide.new
  end
  
  def test_new_diagnosis
    diagnosis = @guide.new_diagnosis :_id => @key
    assert_equal @key, diagnosis._id
  end
  
  def test_diagnose
    @guide.receiver = @guide
    
    @guide.diagnose @key do
      assert_equal @guide.diagnoses.first, @guide.receiver
    end
    assert_equal @guide, @guide.receiver
  end
  
  def test_symptom
    @guide.receiver = @guide.new_diagnosis :_id => @key
    @guide.symptom @key
    assert_equal @key, @guide.receiver.symptoms.first
  end
  
  def test_disease
    @guide.receiver = @guide.new_diagnosis :_id => @key
    @guide.disease @key
    assert_equal @key, @guide.receiver.disease
  end
  
  def test_diagnosis_description
    @guide.receiver = @guide.new_diagnosis :_id => @key
    @guide.description @key
    assert_equal @key, @guide.receiver.description
  end
  
  def test_low_risk
    @guide.receiver = @guide.new_diagnosis :_id => @key
    @guide.low_risk
    assert @guide.receiver.low_risk
  end
end
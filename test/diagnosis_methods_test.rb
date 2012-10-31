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

  def test_diagnose_with_name
    @guide.receiver = @guide
    @guide.diagnose @key, 'test' do
      assert_equal 'test', @guide.diagnoses.first.name
    end
  end
  
  def test_symptom
    @guide.receiver = @guide.new_diagnosis :_id => @key
    @guide.symptom @key

    symptom = @guide.receiver.symptoms.first
    assert_equal @key, symptom.answers.first
    assert_equal 1, symptom.weight
  end

  def test_multi_answer_symptom
    @guide.receiver = @guide.new_diagnosis :_id => @key
    @guide.symptom :first, :second

    symptom = @guide.receiver.symptoms.first
    assert_equal :first, symptom.answers.first
    assert_equal :second, symptom.answers.last
  end
  
  def test_weighted_symptom  
    @guide.receiver = @guide.new_diagnosis :_id => @key
    @guide.symptom @key, 0.25

    symptom = @guide.receiver.symptoms.first
    assert_equal @key, symptom.answers.first
    assert_equal 0.25, symptom.weight
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

  def test_risk
    @guide.receiver = @guide.new_diagnosis :_id => @key
    @guide.risk 1.1
    assert_equal 1.1, @guide.receiver.weight
  end
end
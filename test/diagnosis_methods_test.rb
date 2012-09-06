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

  def test_diagnose_with_weight
    @guide.receiver = @guide
    @guide.diagnose @key, 7.7 do
      assert_equal 7.7, @guide.diagnoses.first.weight
    end
  end 

  def test_diagnose_with_name_and_weight
    @guide.receiver = @guide
    @guide.diagnose @key, 'test', 7.7 do
      assert_equal 'test', @guide.diagnoses.first.name
      assert_equal 7.7, @guide.diagnoses.first.weight
    end
  end 
  
  def test_symptom
    @guide.receiver = @guide.new_diagnosis :_id => @key
    @guide.symptom @key
    assert_equal @key, @guide.receiver.symptoms.first._id
    assert_equal 1, @guide.receiver.symptoms.first.weight
  end
  
  def test_weighted_symptom  
    @guide.receiver = @guide.new_diagnosis :_id => @key
    @guide.symptom @key, 0.25
    assert_equal @key, @guide.receiver.symptoms.last._id
    assert_equal 0.25, @guide.receiver.symptoms.last.weight
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
end
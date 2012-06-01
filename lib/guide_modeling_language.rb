require 'railtie' if defined? ::Rails::Railtie

require 'mongo_mapper'
require 'models/agreement'
require 'models/alert'
require 'models/answer'
require 'models/complaint'
require 'models/condition'
require 'models/diagnosis'
require 'models/group'
require 'models/outcome'
require 'models/question'
require 'models/symptom'

require 'methods/guide_methods'
require 'methods/agreement_methods'
require 'methods/outcome_methods'
require 'methods/diagnosis_methods'
require 'methods/question_methods'
require 'methods/answer_methods'
require 'methods/complaint_methods'

require 'dsl'
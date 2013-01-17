# Earlydoc Guide Modeling Language

Earlydoc formalizes health industry guidelines by using a "domain specific language" to translate natural language medical advice into structured data. This document describes how to author guides using this modeling language.

### Overview

The main principle of the modeling language is to keep the formalized guidelines as similar as possible to the original source literature in order to facilitate professional review and minimize interpretation errors. Because logical complexity is unavoidable, the idea is not to make complex things simple, but rather to make them *clear*; an important distinction.

Guides can be written in any text editor, and then read by Earlydoc's various health modules for analysis or patient triage.

The modeling language is "declarative", and authoring a guide entails writing a number of statements, one per line, each of which defines a piece of data for the guide, for example a question, diagnosis, or outcome. Authors, then, simply write a series of facts, mostly describing relationships between data. The style is designed to be read linearly, in the same manner as clinical staff would read the original guides.

The following is an example question about a patient's fever formalized in the modeling language: 

    question :do_you_have_fever do
      required
      explanation :measure_and_indicate_temp
      answer :no_fever
      answer :fever_higher_then_40
    end

The important thing is to get a sense of the structure of the language; the specifics of the commands themselves are explained further below.

### Blocks

In the example question, the content is indented in a "do..end" block. This convention signifies that the statements inside the block refer to the question. This block convention is used for various statements in the language as a way to define context, but also to help visually group related information for the author/reader.

Blocks can be nested, and in fact the guide itself always acts as the parent block for all of its content.

### Keys

All text in the modeling language is specified using "keys", short underscored phrases that begin with a colon, e.g. :some_key_word_phrase. 

Keys serve several purposes, the first and foremost being a way to easily refer to much longer sentences or paragraphs of text. Because of this, keys should be named using minimal words necessary to summarize the text to which they refer, striking a balance between information and brevity. 

The text referred to by keys will also be translated to other languages, which is another reason to write the guides using keys instead of actual text as it would appear to a patient: it's necessary to abstract the text away from the guide formalization for localization purposes.

Finally, keys are often used within guide logic as a unique identifier for a piece of data, a fact about a patient, or general medical information. This greatly simplifies the data structures which Zorgblik uses, enabling much of the data (e.g. a patient's triage answers) to be modeled as simple lists of keys. If the keys are named in a descriptive way, their meaning should be evident even when viewed out of context.

### Ordering

In general, the order in which statements are given in the guide does not matter. So long as a statement is in the correct block, it doesn't matter where it appears relative to others. In the cases where order matters (with outcomes, for example) this is noted in the documentation.

### DSL

The DSL comprises a number of commands used to describe medical guides. These guides take the form of a series of questions, along with the medical information (e.g. diagnoses, symptoms) that can be inferred and the actions that can be recommended (e.g. see a doctor) on the basis of answers to these questions.

#### Command Reference

##### Index

* **Guides**  
  define  
  version_number  
  illustration  
  description  
* **Complaints**  
  complaint  
  illustration  
  given  
  explanation  
* **Outcomes**  
  outcome  
  summarize  
  warn  
  header  
  paragraph  
  tip  
  given  
  recommend  
  indicator  
* **Questions**  
  group  
  question  
  illustration
  required  
  explanation  
  warning  
  given

* **Answers**  
  answer  
  illustration  
  explanation  
* **Diagnoses**  
  diagnose  
  description  
  disease  
  risk  
  symptom  

##### Guides

+ **define**

  BLOCK: yes  
  PARAMETERS: guide name key  
  NOTES: The `define` block is the only required command in the DSL, and serves as the parent block for all other guide content. The `guide name key` itself (not its translation) is used throughout the UI and website URLs, and so should be chosen in consideration of usability/SEO.  
  EXAMPLE:

        define :my_guide do  
          ...  
        end

+ **version_number**

  BLOCK: no  
  PARAMETERS: version number  
  NOTES: The `version number` is used to indicate modifications to a guide that may materially change how a patient experiences the triage. This number should be updated whenever a guide is changed in such a way that its content could change a previous triage result.
  EXAMPLE:  

        define :my_guide do  
          version_number '1.0'  
        end


+ **illustration**

  BLOCK: no  
  PARAMETERS: path to image asset  
  NOTES: The illustration references an image asset for the guide used to visually represent it in the triage UI whenever guide thumbnails are displayed.  
  EXAMPLE:  

        define :my_guide do  
          illustration 'symptoms/my_symptom.png'  
        end  

+ **description**

  BLOCK: no  
  PARAMETERS: description key  
  NOTES: The `guide description key` text is displayed to the user in the triage UI.  
  EXAMPLE:

        define :my_guide do  
          description :my_guide_summary  
        end  

+ **body**

  BLOCK: no
  PARAMETERS: anatomy title key, anatomy explanation text key, anatomy image key
  NOTES: The `body` command displays a box of anatomical information about the a part in the triage UI. The `anatomy image` references an `image asset name` for the body part used to visually represent it in the triage UI. In order to localize the images, a key is used to refer to the illustration instead of an image path.
  EXAMPLE:

        define :my_guide do  
          body :how_does_your_body_work, :how_body_works_explanation, :anatomy_image_png  
        end        

##### Complaints

+ **complain**

  BLOCK: yes  
  PARAMETERS: complaint name key  
  NOTES: A `complaint` represents an issue causing any number of possible symptoms. A patient is considered to have a complaint if they have provided any of the given answer conditions (see below) in the triage. Multiple `complain` statements can be given in the guide. The `complaint name key` text is displayed to the user in the triage UI.
  EXAMPLE:

        complain :some_complaint do  
          ...  
        end  

+ **illustration**

  BLOCK: no  
  PARAMETERS: image asset path
  NOTES: The `illustration` references an image stored in the `image asset path` for the complaint used to visually represent it in the triage UI when complaint thumbnails are displayed.  
  EXAMPLE:

        complain :some_complaint do  
          illustration 'some_complaint.png'  
        end  

+ **given**

  BLOCK: no  
  PARAMETERS: answer key  
  NOTES: This logical condition associates the complaint with an `answer key` defined for an answer elsewhere in the guide; if a patient gives that answer, then they are assumed to have the complaint. Multiple `given` statements can be provided if several possible answers would indicate the complaint.  
  EXAMPLE:

        complain :some_complaint do  
          given :answer_one  
          given :answer_two  
        end

+ **explanation**

  BLOCK: no  
  PARAMETERS: explanation key  
  NOTES: The complaint `explanation key` text is displayed to the user in the triage UI.  
  EXAMPLE:

        complain :some_complaint do  
          explanation :info_about_the_complaint  
        end  

##### Outcomes

+ **outcome**

  BLOCK: yes  
  PARAMETERS: outcome name key  
  NOTES: An `outcome` represents a recommendation for a patient's next action (visit a doctor or wait) based on answers they provided to the triage. Multiple outcome blocks can be defined in a guide, and the order which they are defined implies an *urgency level* such that the first outcome defined in the guide is the most urgent and the last outcome the least.  
  EXAMPLE:

        outcome :see_a_doctor_now do  
        end  
        ...  
        outcome :see_a_doctor_tomorrow do  
        end

+ **summarize**

  BLOCK: no  
  PARAMETERS: summary title key, summary text key  
  NOTES: The outcome summary is displayed to the user in the triage UI, and consists of two parts: (1) a title and (2) text body.  
  EXAMPLE:

        outcome :see_a_doctor_later do  
          summarize :is_it_serious, :your_complaints_are_not_serious  
        end

+ **warn**

  BLOCK: no  
  PARAMETERS: warning key  
  NOTES: The `warning key` text is displayed to the user in the triage UI.  
  EXAMPLE:

        outcome :see_a_doctor_later do  
          warn :this_does_not_replace_doctor_contact  
        end  

+ **sick_days**

  BLOCK: no  
  PARAMETERS: base number of sick days
  NOTES: The `base number of sick days` is the number of days a user is told to wait before seeing a doctor in the triage display UI, minus the number of days which they have suffered the complaint (if an applicable question exists). This value is only used for outcome urgency level 4.
  EXAMPLE:

        outcome :see_a_doctor_later do  
          sick_days 7
        end

+ **header**

  BLOCK: no  
  PARAMETERS: header key  
  NOTES: The `header key` text is displayed to the user in the triage UI. The triage display UI supports up to 4 different `header` slots.  
  EXAMPLE:

        outcome :see_a_doctor_later do  
          header :some_text  
          header :some_more_text  
          header :final_text  
        end

+ **paragraph**

  BLOCK: no  
  PARAMETERS: paragraph key  
  NOTES: The `paragraph key` text is used in conjunction with header text and displayed to the user in the triage UI. The triage display UI supports up to 6 different `paragraph` slots.  
  EXAMPLE:

        outcome :see_a_doctor_later do  
          paragraph :some_text  
        end  

+ **tip**

  BLOCK: no  
  PARAMETERS: tip key 
  NOTES: The `tip key` text is displayed to the user in the triage UI in a bullet list, and advises the patient on self-help steps. Multiple `tip` statements can be provided.  
  EXAMPLE:

        outcome :see_a_doctor_later do  
          tip :do_something  
          tip :do_something_else  
          tip :do_not_do_something  
        end

+ **given**

  BLOCK: no  
  PARAMETERS: a comma-separated list of one or more answer keys  
  NOTES: This conditional associates the outcome with answers defined elsewhere in the guide; if a patient provides those answers in the triage, then they are triaged for that outcome. If more than one `answer key` is given, the condition requires the patient to have supplied *all* the answers. Multiple `given` statements can also be provided if several possible answer(s) would produce the outcome. Note: outcomes are considered in the order they are defined, from most to least urgent.  
  EXAMPLE:

        outcome :see_a_doctor_later do  
          given :first_answer, :second_answer  
          given :another_answer  
        end

+ **recommend**

  BLOCK: no  
  PARAMETERS: recommendation key  
  NOTES: The `recommendation key` text is displayed to the user in the triage UI, and indicates the general action the user should take for the outcome.  
  EXAMPLE:

        outcome :see_a_doctor_later do  
          recommend :go_see_a_doctor_on_monday  
        end  

+ **indicator**

  BLOCK: no  
  PARAMETERS: indicator key  
  NOTES: The `indicator key` text is displayed to the user in the triage UI in a bullet list, and indicates signs that the patient may still need to see a doctor. Multiple `indicator` statements can be provided. Indicators can be displayed conditionally based on answers provided by the patient. These conditions are defined with a `given` statement inside an `indicator` block, just as the `given` statement is used for the outcome itself: if an indicator has conditions, then it is shown in the triagre UI if and only if the patient's responses meet the conditions.
  EXAMPLE:

        outcome :see_a_doctor_later do  
          indicator :if_some_symptom  
          indicator :if_some_other_symptom  do
            given :an_answer
          end
        end

##### Questions

+ **group**

  BLOCK: yes  
  PARAMETERS: none  
  NOTES: All questions must be contained within a `group`, which means that a guide should always have at least one group. There are two possible group values: `symptoms` and `diagnostics`. The symptoms group should contain all the questions necessary to perform an accurate triage. The diagnostics group should contain all other inessential questions that can be used to provide further, more detailed diagnosis. The two groups question are displayed to the user in the triage UI in separate, distinct ways. If a diagnostics group is not provided, the triage UI will only show the symptom-related questions. 
  EXAMPLE:  

        group :symptoms do  
          ...  
        end  
        group :diagnostics do  
          ...  
        end

+ **question**

  BLOCK: yes  
  PARAMETERS: question key, question type (optional)  
  NOTES: The given `question key` text is displayed as a title in the triage UI. The display of the question itself depends on the `question type`, which may be any one of three possible options - :pick_one (radio button, default), :pick_any (checkbox), :rank (numbered checkbox)  
  EXAMPLE:  

        group :symptom_questions do  
          question :some_question, :pick_one do  
            ...  
          end  
        end  

+ **illustration**

  BLOCK: no  
  PARAMETERS: image asset name key  
  NOTES: The `illustration` references an `image asset name` for the question used to visually represent it in the triage UI. In order to localize the images, a key is used to refer to the illustration instead of an image path.  
  EXAMPLE:  

        question :some_question do  
          illustration :something_png  
        end  

+ **required**

  BLOCK: no  
  PARAMETERS: none  
  NOTES: If a question is marked `required` then the user must answer it before progressing in the triage UI.  
  EXAMPLE:  

        question :some_question do  
          required  
        end  


+ **explanation**

  BLOCK: no  
  PARAMETERS: explanation key  
  NOTES: The question `explanation key` text is displayed to the user in the triage UI.  
  EXAMPLE:

        question :some_question do  
          explanation :details_about_the_question  
        end  

+ **warning**

  BLOCK: no  
  PARAMETERS: answer key, warning key  
  NOTES: The `warning key` text is displayed to the user in the triage UI when they answer the question with the given `answer key`.  
  EXAMPLE:

        question :some_question do  
          warning :serious_answer, :take_action_immediately  
        end  

+ **given**

  BLOCK: no  
  PARAMETERS: answer key
  NOTES: This logical condition associates the question with an `answer key` defined for an answer elsewhere in the guide; if a patient gives that answer, then the question is displayed in the triage UI. If more than one `answer key` is given, the condition requires the patient to have supplied *all* the answers. Multiple `given` statements can also be provided if several possible answer(s) would activate the question for display. 
  EXAMPLE:

        question :some_question do  
          given :answer_one, :answer_three
          given :answer_two
        end


##### Answers


+ **answer**

  BLOCK: optional  
  PARAMETERS: answer key  
  NOTES: The `answer key` text is displayed as a label in the triage UI. This `answer key` will be referenced throughout various triage logic, and so it MUST BE UNIQUE from all the other answer keys in the guide. At minimum, an answer is just a text key, but there are additional properties which can be defined in an optional answer block if necessary. At minimum two `answer` statements should always be defined for a question.
  EXAMPLE:  

        question :some_question do  
          answer :something  
          answer :something_else do  
            ...  
          end  
        end  

+ **illustration**

  BLOCK: no  
  PARAMETERS: image asset path
  NOTES: The `illustration` references an `image asset path` for the answer used to visually represent it in the triage UI.  
  EXAMPLE:

        answer :some_answer do  
          illustration 'complaints/cough_mucus.png'  
        end  

+ **explanation**

  BLOCK: no  
  PARAMETERS: explanation key  
  NOTES: The answer `explanation key` text is displayed to the user in the triage UI.  
  EXAMPLE:

        answer :some_answer do  
          explanation :details_about_the_answer  
        end  


##### Diagnoses

+ **diagnose**

  BLOCK: yes  
  PARAMETERS: diagnosis key, common name (optional)  
  NOTES: A diagnosis is a probable illness or injury associated with one or more possible symptoms (see below). Multiple diagnoses will usually be defined for most guides. The `diagnosis key` text is displayed to the user in the triage UI. If a `common name` is supplied, this (presumably more friendly) name will be used in the UI instead of the key. 
  EXAMPLE:

        diagnose :some_illness do  
          ...  
        end  
        diagnose :rare_illness, :friendly_name do  
          ...  
        end  

+ **description**

  BLOCK: no  
  PARAMETERS: description key  
  NOTES: The diagnosis `description key` text is displayed to the user in the triage UI.
  EXAMPLE:  

        diagnose :some_illness do  
          description :info_about_illness  
        end 

+ **disease**

  BLOCK: no  
  PARAMETERS: disease key  
  NOTES: The diagnosis `disease key` is used to match the diagnosis with a disease page the triage UI; e.g. if the page name is `illness.html` then the disease key should translate to the text `illness`.  
  EXAMPLE:  

        diagnose :some_illness do  
          disease :illness  
        end 

+ **risk**

  BLOCK: no  
  PARAMETERS:  weight  
  NOTES: The `risk` of a diagnosis represents the base liklihood that someone tiraged for this guide is to have that diagnosis. The `weight` determines the order of a given diagnosis relative to other diagnoses, such that a diagnosis with a high weight will appear before others in the triage UI. Note: this weight is added to the weights of any other symptoms given by a user's answers. By default a diagnosis will have a weight of 0, meaning that the diagnoses order would be determined entirely by symptoms.  
  EXAMPLE:  

        diagnose :some_illness do  
          risk 1.2
        end   

+ **symptom**

  BLOCK: no  
  PARAMETERS: symptom key(s), weight (optional. default = 1)  
  NOTES: Each `symptom key` should match an `answer key` defined for an answer elsewhere in the guide. If a patient answers with any of the given symptoms, the diagnosis may be displayed in the triage UI. The more symptoms a user has in their answers, the more likely the triage UI will consider this diagnosis above others. Multiple `symptom` statements can and usually will be provided if several possible symptoms would indicate the diagnosis. Multiple answer keys can be provided for individual symptoms. The symptom's `weight` determines the influence of a given symptom relative to other weighted symptoms, such that a symptom with a high weight implies a diagnosis more than a symptom with a lower weight. In order to be included in the results, a diagnosis must have a total weight (risk + sum of symptom weights) of 1 or greater.
  EXAMPLE:

        diagnose :some_illness do  
          symptom :one_possible_symptom  
          symptom :a_dependent_symptom, :the_other_dependent_symptom, 1.5
          symptom :unimportant_symptom, 0.25
        end  

### References

Sore Throat Guide:
https://github.com/Guidecase/Earlydoc/blob/master/lib/guides/sore_throat.rb

Guide Template:
https://github.com/Guidecase/Earlydoc/blob/master/lib/generators/guide_generator.rb

Document Nesting Diagram:
https://github.com/Guidecase/BizDev/raw/master/System/DSL%20Document%20Nesting%20Diagram.png
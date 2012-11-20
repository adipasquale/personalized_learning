registration      = Step.create name: "registration",   order: 1
pre_test          = Step.create name: "pre-test",   order: 2
practice          = Step.create name: "practice",   order: 3
post_test         = Step.create name: "post-test",  order: 4
questionnaire_step = Step.create name: "questionnaire",  order: 5

User.create login: 'dr.donghee', is_admin: true, material_type: "personalized", step_id: registration.id
User.create login: 'dr.adrien', is_admin: true, material_type: "personalized", step_id: registration.id
testuser = User.create login: 'testuser', material_type: "personalized", step_id: registration.id

quaire = Questionnaire.create name:"final questionnaire", step_id: questionnaire_step.id
q1 = Question.create questionnaire_id: quaire.id, text: "Did you feel familiar with the practice materials stories ?",
  choices_attributes: [
    { text: "1", label: "not familiar at all" },
    { text: "2", label: "" },
    { text: "3", label: "so-so" },
    { text: "4", label: "" },
    { text: "5", label: "very familiar" }
  ]
q2 = Question.create questionnaire_id: quaire.id, text: "Did you think that the practice materials stories were plausible ? (were they likely to happen in real life ?)",
  choices_attributes: [
    { text: "1", label: "not plausible at all" },
    { text: "2", label: "" },
    { text: "3", label: "bland stories / no opinion" },
    { text: "4", label: "" },
    { text: "5", label: "very likely to happen" }
  ]
q3 = Question.create questionnaire_id: quaire.id, text: "Did you find the practice materials easier than the final test material ?",
  choices_attributes: [
    { text: "1", label: "practice harder than test" },
    { text: "2", label: "" },
    { text: "3", label: "same difficulty" },
    { text: "4", label: "" },
    { text: "5", label: "practice easier than test" }
  ]
q4 = Question.create questionnaire_id: quaire.id, text: "Did you think that the the practice materials contexts were complicated to understand compared to your usual studying materials ?",
  choices_attributes: [
    { text: "1", label: "simpler than usual" },
    { text: "2", label: "" },
    { text: "3", label: "same difficulty" },
    { text: "4", label: "" },
    { text: "5", label: "more complicated than usual" }
  ]
q5 = Question.create questionnaire_id: quaire.id, text: "Please write down your comments and feelings about the materials provided."
q6 = Question.create questionnaire_id: quaire.id, text: "Please write down your comments and feelings about this experiment process."


Task.create( name: "pre test", step_id: pre_test.id, material: "lorem ipsum" )
Task.create( name: "post test", step_id: post_test.id, material: "lorem ipsum" )
Task.create( name: "practice task 1", step_id: practice.id, material: "lorem ipsum" )
Task.create( name: "practice task 2", step_id: practice.id, material: "lorem ipsum" )
Task.create( name: "practice task 3", step_id: practice.id, material: "lorem ipsum" )
Task.create( name: "practice task 4", step_id: practice.id, material: "lorem ipsum" )
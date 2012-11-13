User.create login: 'dr.donghee', is_admin: true
User.create login: 'dr.adrien', is_admin: true
User.create login: 'testuser'

quaire = Questionnaire.create name:"final questionnaire"
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
address = Trait.create name: "address"

User.create login: 'dr.donghee', is_admin: true
User.create login: 'dr.adrien', is_admin: true
testuser = User.create login: 'testuser'
UserTrait.create user_id: testuser.id, trait_id: address.id, value: '4-13-14 Shinohara Kitamachi, Chuo-ku, Osaka 541, Japan', material_type: "personalized"

pre_test    = Step.create name: "pre-test",   order: 1
practice    = Step.create name: "practice",   order: 2
final_test  = Step.create name: "final test", order: 3
post_test   = Step.create name: "post-test",  order: 4

quaire = Questionnaire.create name:"final questionnaire", step_id: post_test.id
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

Task.create( name: "example", step_id: practice.id, material: "
<p class='expeditor'>
$address$ <br />
March 22
</p>
<p class='destinator'>
Mr. S. Kayasit, President <br />
Golden Crown Resorts <br />
31/66 Paya Road <br />
Patong Beach <br />
Phuket 83150 <br />
Thailand
</p>

<p>
Dear Mr. Kayasit :
</p>
<p>
Thank you very much for offering me the position of Properties Agent for your
office in Phuket. I appreciate your discussing the details of the position with
me and giving me time to consider your offer. I also enjoyed meeting Mr. Van
Vliet, the current Properties Agent in Phuket.
</p>
<p>
You have a fine organization and there are many aspects of the position which
are very appealing to me. However, I believe it is in our mutual best interest
that I decline your kind offer. I have decided to accept a position as the
Sales Director for a smaller company located in Kyoto. This has been a difficult
decision for me, but I believe it is the appropriate one for my career and
family at this time.
</p>
<p>
I want to thank you for the consideration and courtesy given to me. It was a
pleasure meeting you and Mr. Puapondh, the head of Operations.
</p>
<p class='signature'>
  Sincerely,
  Ryusuke Hayashida
</p>
", introns_attributes: [
  { slug: 'address', trait_id: address.id }
])
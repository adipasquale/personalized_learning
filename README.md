== Personalized Learning

This is the quick & dirty implementation of a personalized learning system,
as a part of a 2012 KAIST course experiment run together with Donghee Hong.

= What's the purpose ?

We want to see the benefits of having customized material for learning how to
perform a typical english language test : TOEIC part 7.
Customized Material refers to a document where some proper names, some
pictures, or some context sentences are personalized for each user, depending
on their own names, their friends names, their hobbies ...

= How does it work

1. Admins first create Profile Traits, which are pieces of infos describing a
user. They can be either an open text trait like 'name', 'age' ... or a
multiple choice trait like 'passion' => 'music', 'dancing' ...
2. Admins then create Tasks. Each contains :
* a pattern material, which is an annotated HTML text. The annotations indicate
the parts that can be customized.
* a list of annotations
* a list of questions and their answer choices
3. Users fill in the answers for each task. They are presented with a
customized or classical material, depending on the admin choice (we need a
control group).

In this implementation, Admins also have to create the Users, as there is
no password nor sign up process, useless in the context of our in-class
experiment.
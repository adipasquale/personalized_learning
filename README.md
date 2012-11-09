# Personalized Learning

This is a simple personalized learning system, built as a part of a 2012 KAIST course experiment run together with Donghee Hong.

## What's the purpose ?

We want to see the benefits of having customized material for learning how to
perform a typical english language test : TOEIC part 7.
Customized Material refers to a document where some proper names, some
pictures, or some context sentences are personalized for each user, depending
on their own names, their friends names, their hobbies ...

## How does it work

1. Admins create Profile Traits
- Admins create Tasks
- Users fill in their Profile Traits
- The system generates customized Tasks for each User
- Users submit answers to the Questions for each Task.

In this early implementation, Admins also have to create the Users, as there is no password nor sign up process, useless in the context of our in-class
experiment.

## Models detail

### Tasks

A Task designates an exercise close to TOEIC part 7 type exercises.

* a pattern material, which is an annotated HTML text. The annotations indicate
the parts that can be customized.
* a list of annotations
* a list of questions and their answer choices

### Profile Traits

A Trait is a piece of information describing a User.
They can be either an open text trait like 'name', 'age' ... or a
multiple choice trait like 'passion' => 'music', 'dancing' ...

### Misc

Users should be presented with either a customized or classical material, depending on the admin choice (we need a control group).
We also have to account for the different steps of the experiment : pre-test, practice, test, post-test ...

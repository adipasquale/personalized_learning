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

![UML Diagram](https://www.lucidchart.com/publicSegments/view/50c96911-3410-4303-8d47-3d0d0a7c4e7c/image.png)

### Users

`Users` are only identified via their login (no password required).
Security is not a matter at all for our application, since it is used locally only.

Each `User` is associated to a current `Step`, which in turn defines the subset of
`Tasks` / `Questionnaires` they have to perform.

`Users` should be presented with either a customized or classical material, which
is defined by an attribute in the `User` class. It is only accessible to admin users.

### Tasks / Questionnaires

A `Task` designates an exercise similar to TOEIC part 7 type exercises.
It contains a _material_, which is an annotated HTML text. The annotations
are called `Exon` ([say what ?!](http://wikipedia.org/wiki/Exon)), and look like this : `$captain_name$`. They designate
the parts of a text that can be customized.

### Questions

The `Questions` have a text (that can contain `Exons`), and a few `Choices` associated (which themselves can
contain `Exons`).
The link between these `Exons` is made via the parent `Task`, which prevents local duplication.

### Profile Traits

A `Trait` is [a piece of information](http://purl.org/vocabularies/princeton/wn30/synset-trait-noun-1) describing a `User`.
There are both open text traits like 'name', 'age' ... and
multiple choice traits like 'passion' => ['music', 'dance', 'astronomy']

## Retrieve production DB to local environment
```
heroku pgbackups:capture
curl -o latest.dump `heroku pgbackups:url`
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U adipasquale -d pl_development latest.dump
```

## Retreive questionnaires choices (not implemented in backend)
```ruby
CSV.open("script/answers_choices.csv", "wb") do |csv|
  csv << ["user_login", "material_type", "text", "choice", "choice_label"]
  answers.map {|a| [a.user.login, a.user.material_type, a.question.text, a.choice.text, a.choice.label]}.each do |a|
    csv << a
  end
end
```

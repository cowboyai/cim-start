## Subjects
Messages run by Subject.

This is a Dot Delimited String with some structure
  - foo
    - gives me everything on the foo channel
  - foo.bar
    - gives me everything on foo.bar, but nothing in foo
  - foo.*
    - gives me foo and foo.bar
  - foo.bar.>
    - gives me everything under foo.bar, i.e. foo.bar.baz, foo.bar.bay

With our Domain Model, this becomes a very easy pattern to create automatically.
All Strings are now part of the Domain, this is a lot different than passing around everything as a string in a web app. It's much more akin to passing around a Constant, because it acts that way.
For Example, "Yellow".
It's a color.
It's a behavior.
It's other things, those things depend on Context.

The Domain Model Language provides that Context.

[Reactive System](./reactive.md)

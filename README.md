## Lazy Enumerator in ruby

* we can make a monad,
  * it stores:
    1. original_collection
    2. transformation proc
  * every time(map, select, reject, drop):
    * create a new monad, with:
      1. the same original_collection
      2. adjusted transformation proc

## Actor model

* http://adit.io/posts/2013-05-15-Locks,-Actors,-And-STM-In-Pictures.html

* why actor model?
    * multi-threads
    * yet share things without lock code
    * yet don't manage/schedule threads pool by my own

* how?
    * each actor object is a thread
    * let each object use locks by itself:
        * queueing messages
    * threads will be scheduled/managed by library

* how to design code into actors
    * mutations on the same state should inside the same actor object
    * pass self(Actor.current) to the mutation_actor, let mutation_actor to call me after it mutates state

## Monads

* why monads? -- make code easy to read/write in the constraints of FP
    1. disallow assignment/mutation in code --> so, no side-effect(or free variables)
    2. provide a way to force execution order --> so, side-effect lazy things can run in order
    3. yet make code easy to read and write

* how monad achieve them:
    1. wrap: wrap the value inside a decorator, so that we can add extra features to it
    2. callback: pass function/code to a monad object, rather than call functions
    3. chainable: always return the same monad type
    4. persistent: each time it creates a new monad to wrap new value, rather than mutate old value

### Three useful monads: writer, reader, state

* http://adit.io/posts/2013-06-10-three-useful-monads.html

* writer_monad:
    1. wrap a pair: [value, logs]
    2. map:
        1. sequential computation
        2. each computation: (value) -> value'
        3. log is added only by monad
    3. when to use: sequential executions, yet add logs

* reader_monad:
    1. wrap a function: s->s'
    2. map:
        1. sequential computation
        2. each computation: (state) -> state'
    3. when to use: build a complex sequential function by chaining separate ones

* state_monad:
    1. wrap a function: s -> [value, s']
    2. map:
        1. sequential computation
        2. each computation: (value) -> value'
        3. state and first value is updated only by monad
    3. when to use:
        * build a complex sequential function by chaining separate ones
        * which will also update state(e.g. by inheritance with extra methods)

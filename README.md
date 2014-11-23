## Monads

* why monads? -- make code easy to read/write in the constraints of FP
    1. disallow assignment/mutation in code --> so, no side-effect(or free variables)
    2. provide a way to force execution order --> so, side-effect lazy things can run in order
    3. yet make code easy to read and write

* how monad achieve them:
    1. pass function/code to a monad object, rather than call functions
    2. chainable
    3. each time it will create a new monad object of same monad type, rather than mutate value

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

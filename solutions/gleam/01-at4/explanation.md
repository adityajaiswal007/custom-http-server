The entry point for your HTTP server implementation is in `src/main.gleam`.

Study and uncomment the relevant code: 

```gleam
// Uncomment this block to pass the first stage

import gleam/erlang/process
import gleam/option.{None}
import gleam/otp/actor
import glisten
```

```gleam
// Uncomment this block to pass the first stage

let assert Ok(_) =
  glisten.handler(fn(_conn) { #(Nil, None) }, fn(_msg, state, _conn) {
    io.println("Received message!")
    actor.continue(state)
  })
  |> glisten.serve(4221)

process.sleep_forever()
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```

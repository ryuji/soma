# Soma ([杣](https://ja.wikipedia.org/wiki/%E6%9D%A3))

[![CI](https://github.com/ryuji/soma/workflows/CI/badge.svg)](https://github.com/ryuji/soma/actions?query=branch%3Amaster+workflow%3ACI)

Structured logging utility for the [Crystal language](http://crystal-lang.org/).

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     soma:
       github: ryuji/soma
   ```

2. Run `shards install`

## Usage

### JSON formatter

```crystal
require "soma"

# detects if io is not a tty and sets it.
Soma.setup_from_env

# or specify it explicitly.
backend_with_formatter = Log::IOBackend.new(formatter: Soma::JSONFormatter.new)
Log.setup(:info, backend_with_formatter)
```

```json
{"timestamp":"2020-06-22T05:58:20Z","level":"trace","message":"Logs a message with trace log level.","progname":"main","source":"","data":{},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"debug","message":"Logs a message with debug log level.","progname":"main","source":"","data":{},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"info","message":"Logs a message with info log level.","progname":"main","source":"","data":{},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"notice","message":"Logs a message with notice log level.","progname":"main","source":"","data":{},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"warn","message":"Logs a message with warn log level.","progname":"main","source":"","data":{},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"error","message":"Logs a message with error log level.","progname":"main","source":"","data":{},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"fatal","message":"Logs a message with fatal log level.","progname":"main","source":"","data":{},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"info","message":"User logged in","progname":"main","source":"","data":{"user_id":42},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"warn","message":"Oh no!","progname":"main","source":"","data":{"user_id":42},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"},"exception":{"class":"Exception","message":"Something is wrong","backtrace":"Something is wrong (Exception)\n  from samples/main.cr:16:3 in '__crystal_main'\n  from ../usr/share/crystal/src/crystal/main.cr:105:5 in 'main_user_code'\n  from ../usr/share/crystal/src/crystal/main.cr:91:7 in 'main'\n  from ../usr/share/crystal/src/crystal/main.cr:114:3 in 'main'\n  from ???"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"error","message":"Oh no!","progname":"main","source":"","data":{},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"},"exception":{"class":"Exception","message":"Something is wrong","backtrace":"Something is wrong (Exception)\n  from samples/main.cr:16:3 in '__crystal_main'\n  from ../usr/share/crystal/src/crystal/main.cr:105:5 in 'main_user_code'\n  from ../usr/share/crystal/src/crystal/main.cr:91:7 in 'main'\n  from ../usr/share/crystal/src/crystal/main.cr:114:3 in 'main'\n  from ???"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"fatal","message":"Something is wrong","progname":"main","source":"","data":{},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"},"exception":{"class":"Exception","message":"Something is wrong","backtrace":"Something is wrong (Exception)\n  from samples/main.cr:16:3 in '__crystal_main'\n  from ../usr/share/crystal/src/crystal/main.cr:105:5 in 'main_user_code'\n  from ../usr/share/crystal/src/crystal/main.cr:91:7 in 'main'\n  from ../usr/share/crystal/src/crystal/main.cr:114:3 in 'main'\n  from ???"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"info","message":"","progname":"main","source":"","data":{"action":"log_in","user_id":42},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"}}
{"timestamp":"2020-06-22T05:58:20Z","level":"info","message":"This is logged in foo source","progname":"main","source":"foo","data":{},"context":{"hostname":"200884b7e54c","pid":39,"thread":"main"}}
```

### Readable formatter

```crystal
require "soma"

# detects if io is a tty and sets it.
Soma.setup_from_env

# or specify it explicitly.
backend_with_formatter = Log::IOBackend.new(formatter: Soma::ReadableFormatter.new)
Log.setup(:info, backend_with_formatter)
```

![Readable output](https://raw.githubusercontent.com/ryuji/soma/assets/readable.gif)

### Convenience function/macro for logging

```crystal
require "soma"

Soma.setup_from_env

Soma.t("Logs a message with trace log level.")
Soma.d("Logs a message with debug log level.")
Soma.i("Logs a message with info log level.")
Soma.n("Logs a message with notice log level.")
Soma.w("Logs a message with warn log level.")
Soma.e("Logs a message with error log level.")
Soma.f("Logs a message with fatal log level.")

Soma.i("User logged in", user_id: 42) # local data
Soma.w("Oh no!", e, user_id: 42)      # with exception
Soma.e("Oh no!", e)                   # with exception, no local data
Soma.f(e)                             # only exception
Soma.i(action: "log_in", user_id: 42) # empty message

class Foo
  Log = ::Log.for(self) # => Log for foo source

  def do_something
    # use closest `Log` constant in the namespace
    Soma.i("This is logged in foo source")
  end
end
```

## Development

1. [Install Docker](https://docs.docker.com/get-docker/)
2. Run `make`

## Contributing

1. Fork it (<https://github.com/ryuji/soma/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Ryuji Matsumura](https://github.com/ryuji) - creator and maintainer

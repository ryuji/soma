require "../src/soma"

Soma.setup_from_env(default_level: :trace)

Soma.t("Logs a message with trace log level.")
Soma.d("Logs a message with debug log level.")
Soma.i("Logs a message with info log level.")
Soma.n("Logs a message with notice log level.")
Soma.w("Logs a message with warn log level.")
Soma.e("Logs a message with error log level.")
Soma.f("Logs a message with fatal log level.")

Soma.i("User logged in", user_id: 42) # local data

begin
  raise "Something is wrong"
rescue e
  Soma.w("Oh no!", e, user_id: 42) # with exception
  Soma.e("Oh no!", e)              # with exception, no local data
  Soma.f(e)                        # only exception
end

Soma.i(action: "log_in", user_id: 42) # empty message

class Foo
  Log = ::Log.for(self) # => Log for foo source

  def do_something
    # use closest `Log` constant in the namespace
    Soma.i("This is logged in foo source")
  end
end

Foo.new.do_something

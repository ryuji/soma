require "log"

module Soma
  {% for method in %i(trace debug info notice warn error fatal) %}
    macro {{method.chars.first.id}}(message = "", exception = nil, **data)
      \{% if message.is_a?(Var) && !exception %}
        Log.{{method.id}}(exception: \{{message}}, &.emit(\{{message}}.message.to_s, \{{**data}}))
      \{% else %}
        Log.{{method.id}}(exception: \{{exception}}, &.emit(\{{message}}, \{{**data}}))
      \{% end %}
    end
  {% end %}
end

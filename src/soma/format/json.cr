require "json"
require "log"
require "log/json"

struct Soma::JSONFormatter
  include Log::Formatter

  def initialize
  end

  def format(entry : Log::Entry, io : IO)
    payload = {
      :timestamp => entry.timestamp.to_utc,
      :level     => entry.severity.label.downcase,
      :message   => entry.message,
      :progname  => Log.progname,
      :source    => entry.source,
      :data      => entry.data,
      :context   => entry.context.to_h.merge({
        :hostname => System.hostname,
        :pid      => Process.pid,
        :thread   => Fiber.current.name || "0x#{Fiber.current.object_id.to_s(16)}",
      }),
    }

    entry.exception.try do |e|
      payload[:exception] = Log::Metadata.build({
        class:     e.class.name,
        message:   e.message.to_s,
        backtrace: e.inspect_with_backtrace.chomp,
      })
    end

    payload.to_json(io)
  end
end

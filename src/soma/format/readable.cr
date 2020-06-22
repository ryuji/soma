require "colorize"
require "log"

struct Soma::ReadableFormatter
  include Log::Formatter

  private COLOR_OF = {
    Log::Severity::Trace  => :dark_gray,
    Log::Severity::Debug  => :dark_gray,
    Log::Severity::Info   => :light_green,
    Log::Severity::Notice => :light_blue,
    Log::Severity::Warn   => :light_yellow,
    Log::Severity::Error  => :light_red,
    Log::Severity::Fatal  => :light_magenta,
  }

  def initialize
  end

  def format(entry : Log::Entry, io : IO)
    c = COLOR_OF[entry.severity]

    io << entry.timestamp.to_s("%H:%M:%S.%3N")
    io << " | " << (Fiber.current.name || "0x#{Fiber.current.object_id.to_s(16)}").ljust(11)
    io << " | " << entry.severity.label.ljust(6).colorize(c)
    io << " | " << entry.source.ljust(11)
    io << " | " << entry.message.ljust(40).colorize(c)

    entry.context.each do |k, v|
      io << " " << k.colorize(c) << "=" << v
    end

    entry.data.each do |k, v|
      io << " " << k.colorize(c) << "=" << v
    end

    entry.exception.try do |e|
      e.inspect_with_backtrace.chomp.split("\n").each do |s|
        io.puts
        io << s.colorize(c)
      end
    end
  end
end

require "log"

require "./format/json.cr"
require "./format/readable.cr"

module Soma
  def self.setup_from_env(*,
                          builder : Log::Builder = Log.builder,
                          default_level : Log::Severity = Log::Severity::Info,
                          default_sources = "*",
                          log_level_env = "LOG_LEVEL",
                          io : IO = STDOUT)
    formatter = io.tty? ? ReadableFormatter.new : JSONFormatter.new

    Log.setup_from_env(
      builder: builder,
      default_level: default_level,
      default_sources: default_sources,
      log_level_env: log_level_env,
      backend: Log::IOBackend.new(io, formatter: formatter)
    )
  end
end

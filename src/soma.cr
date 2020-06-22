require "./soma/macro.cr"
require "./soma/setup.cr"

module Soma
  VERSION = {{ `shards version #{__DIR__}`.stringify.chomp }}
end

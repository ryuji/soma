require "../spec_helper"

describe Soma do
  describe ".setup_from_env" do
    context "with tty" do
      it "uses readable formatter" do
        Soma.setup_from_env(io: MockTTYIO.new)
        Log.for("").backend.as(Log::IOBackend).formatter.should be_a Soma::ReadableFormatter
      end
    end

    context "no tty" do
      it "uses json formatter" do
        Soma.setup_from_env(io: IO::Memory.new)
        Log.for("").backend.as(Log::IOBackend).formatter.should be_a Soma::JSONFormatter
      end
    end
  end
end

class MockTTYIO < IO::Memory
  def tty?
    true
  end
end

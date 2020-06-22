require "../../spec_helper"

describe Soma::ReadableFormatter do
  describe "#format" do
    context "with exception" do
      it "formats as human readable" do
        io = IO::Memory.new
        entry = Log::Entry.new("", Log::Severity::Info, "message", Log::Metadata.new, Exception.new("error"))

        Soma::ReadableFormatter.new.format(entry, io)

        io.rewind
        io.read_line.split('|').size.should eq 5
        io.read_line.should contain "error (Exception)"
        io.gets.should be_nil
      end
    end

    context "no exception" do
      it "formats as human readable" do
        io = IO::Memory.new
        entry = Log::Entry.new("", Log::Severity::Info, "message", Log::Metadata.new, nil)

        Soma::ReadableFormatter.new.format(entry, io)

        io.rewind
        io.read_line.split('|').size.should eq 5
        io.gets.should be_nil
      end
    end
  end
end

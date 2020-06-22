require "../../spec_helper"

describe Soma::JSONFormatter do
  describe "#format" do
    context "with exception" do
      it "formats as json" do
        io = IO::Memory.new
        entry = Log::Entry.new("", Log::Severity::Info, "message", Log::Metadata.new, Exception.new("error"))

        Soma::JSONFormatter.new.format(entry, io)

        JSON.parse(io.to_s).as_h.keys.should eq %w(timestamp level message progname source data context exception)
      end
    end

    context "no exception" do
      it "formats as json" do
        io = IO::Memory.new
        entry = Log::Entry.new("", Log::Severity::Info, "message", Log::Metadata.new, nil)

        Soma::JSONFormatter.new.format(entry, io)

        JSON.parse(io.to_s).as_h.keys.should eq %w(timestamp level message progname source data context)
      end
    end
  end
end

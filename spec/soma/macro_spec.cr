require "log/spec"

require "../spec_helper"

Log.setup(:none)

describe Soma do
  describe ".t" do
    it "logs as trace" do
      Log.capture do |logs|
        Soma.t("message")
        logs.check(:trace, "message")
      end
    end
  end

  describe ".d" do
    it "logs as debug" do
      Log.capture do |logs|
        Soma.d("message")
        logs.check(:debug, "message")
      end
    end
  end

  describe ".i" do
    it "logs as info" do
      Log.capture do |logs|
        Soma.i("message")
        logs.check(:info, "message")
      end
    end
  end

  describe ".n" do
    it "logs as notice" do
      Log.capture do |logs|
        Soma.n("message")
        logs.check(:notice, "message")
      end
    end
  end

  describe ".w" do
    it "logs as warn" do
      Log.capture do |logs|
        Soma.w("message")
        logs.check(:warn, "message")
      end
    end
  end

  describe ".e" do
    it "logs as error" do
      Log.capture do |logs|
        Soma.e("message")
        logs.check(:error, "message")
      end
    end
  end

  describe ".f" do
    it "logs as fatal" do
      Log.capture do |logs|
        Soma.f("message")
        logs.check(:fatal, "message")
      end
    end
  end

  describe "log" do
    context "with local data" do
      context "with message" do
        it "logs" do
          Log.capture do |logs|
            Soma.i("message", foo: "foo")
            logs.check(:info, "message")
            logs.entry.data[:foo].as_s.should eq "foo"
            logs.entry.exception.should be_nil
          end
        end
      end

      context "with exception" do
        it "logs" do
          Log.capture do |logs|
            e = Exception.new("error")

            Soma.i("message", e, foo: "foo")
            logs.check(:info, "message")
            logs.entry.data[:foo].as_s.should eq "foo"
            logs.entry.exception.should eq e
          end
        end
      end

      context "with exception, no message" do
        it "logs" do
          Log.capture do |logs|
            e = Exception.new("error")

            Soma.i(e, foo: "foo")
            logs.check(:info, "error")
            logs.entry.data[:foo].as_s.should eq "foo"
            logs.entry.exception.should eq e
          end
        end
      end

      context "empty message" do
        it "logs" do
          Log.capture do |logs|
            Soma.i(foo: "foo")
            logs.check(:info, "")
            logs.entry.data[:foo].as_s.should eq "foo"
            logs.entry.exception.should be_nil
          end
        end
      end
    end

    context "no local data" do
      context "with message" do
        it "logs" do
          Log.capture do |logs|
            Soma.i("message")
            logs.check(:info, "message")
            logs.entry.data.empty?.should be_true
            logs.entry.exception.should be_nil
          end
        end
      end

      context "with exception" do
        it "logs" do
          Log.capture do |logs|
            e = Exception.new("error")

            Soma.i("message", e)
            logs.check(:info, "message")
            logs.entry.data.empty?.should be_true
            logs.entry.exception.should eq e
          end
        end
      end

      context "with exception, no message" do
        it "logs" do
          Log.capture do |logs|
            e = Exception.new("error")

            Soma.i(e)
            logs.check(:info, "error")
            logs.entry.data.empty?.should be_true
            logs.entry.exception.should eq e
          end
        end
      end

      context "empty message" do
        it "logs" do
          Log.capture do |logs|
            Soma.i
            logs.check(:info, "")
            logs.entry.data.empty?.should be_true
            logs.entry.exception.should be_nil
          end
        end
      end
    end
  end
end

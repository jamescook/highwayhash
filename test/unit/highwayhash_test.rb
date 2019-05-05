require_relative "../../lib/highwayhash"
require "minitest/autorun"

DEFAULT_KEY = [
  12789292469752986505,
  2604841960524046359,
  16780893305694360733,
  2596697148686325029
].pack("Q4").freeze

describe 'Highwayhash' do
  describe ".hash64 with no arguments" do
    it "returns an argument error" do
      assert_raises ArgumentError do
        Highwayhash.hash64
      end
    end
  end

  describe ".hash64 with only one argument" do
    it "returns an argument error" do
      assert_raises ArgumentError do
        Highwayhash.hash64 "hello world"
      end
    end
  end

  describe ".hash64 with an invalid key size" do
    it "returns an argument error" do
      assert_raises ArgumentError do
        Highwayhash.hash64 "hello world", [1,2,3]
      end

      assert_raises ArgumentError do
        Highwayhash.hash64 "hello world", [1,2,3,4,5]
      end
    end
  end

  describe ".hash64 with a valid key" do
    it "returns the computed hash" do
      assert_equal 4233059316776515400, Highwayhash.hash64("hello world".freeze, DEFAULT_KEY)
    end

    # This is the same test from the google/highwayhash git repo
    it "returns the computed hash (same from vendor)" do
      data = []
      33.times do |i|
        data << (128 + i)
      end

      assert_equal 0x53c516cce478cad7, Highwayhash.hash64(data.pack("C*"), [1,2,3,4].pack("q4"))
    end
  end

  describe ".hash64 given an IO-like input" do
    it "returns the computed hash for StringIO" do
      assert_equal 4233059316776515400, Highwayhash.hash64(StringIO.new("hello world"), DEFAULT_KEY)
    end

    it "returns the computed hash for a File" do
      assert_equal 4233059316776515400, Highwayhash.hash64(File.new("test/fixtures/please_hash_me"), DEFAULT_KEY)
    end
  end
end

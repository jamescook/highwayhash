# frozen_string_literal: true
require 'ffi'

module Highwayhash
  extend FFI::Library
  ffi_lib 'libhighwayhash'

  attach_function :__highway_hash64,
    :HighwayHash64, [
      :pointer,   # secret key (4 uint64 numbers)
      :pointer,   # data to be hashed
      :uint64_t   # length of data
    ], :uint64_t

  private def hash64(input, key)
    raise ArgumentError.new("Key length must be 32 bytes") if key.size != 32

    if input.respond_to?(:read)
      data = input.read
    else
      data = input
    end

    input_size = data.bytesize

    input_p = FFI::MemoryPointer.from_string(data)

    key_p = FFI::MemoryPointer.new(:uint64_t, 4)
    key_p.write_array_of_uint64(key.unpack("Q4"))

    __highway_hash64(key_p, input_p, input_size)
  end
  module_function :hash64
end

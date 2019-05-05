require 'benchmark/ips'
require 'ffi'
require 'securerandom'
require 'digest/md5'
require 'digest/sha2'
require 'digest/sha1'
require_relative '../lib/highwayhash.rb'

str = ("aなbcdef漢字ghijklmnopqrstuvwxyz!@#$%^&*()0987654321-=[];'/.,><な?\1" * 50_000).freeze;nil
key = SecureRandom.random_bytes(32)

Benchmark.ips do |b|
  b.time = 15
  b.report("Highwayhash (#{str.bytesize} bytes)") { Highwayhash.hash64(str, key) }
  b.report("Digest::MD5 (#{str.bytesize} bytes)") { Digest::MD5.hexdigest(str) }
  b.report("Digest::SHA1 (#{str.bytesize} bytes)") { Digest::SHA1.hexdigest(str) }
  b.report("Digest::SHA2 (#{str.bytesize} bytes)") { Digest::SHA2.hexdigest(str) }
  b.compare!
end

str = str.dup[0..15]
Benchmark.ips do |b|
  b.time = 15
  b.report("Highwayhash (16 bytes)") { Highwayhash.hash64(str, key) }
  b.report("Digest::MD5 (16 bytes)") { Digest::MD5.hexdigest(str) }
  b.report("Digest::SHA1 (16 bytes)") { Digest::SHA1.hexdigest(str) }
  b.report("Digest::SHA2 (16 bytes)") { Digest::SHA2.hexdigest(str) }
  b.compare!
end


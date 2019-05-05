# Highwayhash Ruby Bindings

Binding for the HighwayHash64 function defined in google/highwayhash

### Requirements
- highwayhash must be compiled and installed where FFI can find it
  (e.g in /usr/local/lib)

### Usage
```ruby
key = SecureRandom.random_bytes(32) # This should be secret

# Hash of a simple string
puts Highwayhash.hash64("any string", key)

# Hash of an IO-like object (must respond to 'read')
puts Highwayhash.hash64(File.new("/path/to/bee_movie_script.txt", key)
```

### Comparison with other hashing algorithms
Results from running benchmark/bench.rb on Ruby 2.6.3:

```
Calculating -------------------------------------
Highwayhash (3550000 bytes)
                          1.128k (± 5.9%) i/s -     16.983k in  15.107726s
Digest::MD5 (3550000 bytes)
                        185.121  (± 3.8%) i/s -      2.790k in  15.095315s
Digest::SHA1 (3550000 bytes)
                        259.470  (± 3.5%) i/s -      3.900k in  15.049261s
Digest::SHA2 (3550000 bytes)
                        119.173  (± 3.4%) i/s -      1.788k in  15.020991s

Comparison:
Highwayhash (3550000 bytes):     1128.2 i/s
Digest::SHA1 (3550000 bytes):      259.5 i/s - 4.35x  slower
Digest::MD5 (3550000 bytes):      185.1 i/s - 6.09x  slower
Digest::SHA2 (3550000 bytes):      119.2 i/s - 9.47x  slower

Calculating -------------------------------------
Highwayhash (16 bytes)
                        351.403k (± 5.3%) i/s -      5.278M in  15.063735s
Digest::MD5 (16 bytes)
                        793.475k (± 3.5%) i/s -     11.889M in  15.003608s
Digest::SHA1 (16 bytes)
                        760.100k (± 7.2%) i/s -     11.357M in  15.025721s
Digest::SHA2 (16 bytes)
                        443.165k (± 5.6%) i/s -      6.647M in  15.052250s

Comparison:
Digest::MD5 (16 bytes):   793474.8 i/s
Digest::SHA1 (16 bytes):   760099.8 i/s - same-ish: difference falls within error
Digest::SHA2 (16 bytes):   443165.2 i/s - 1.79x  slower
Highwayhash (16 bytes):   351402.6 i/s - 2.26x  slower
```

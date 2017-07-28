#!/usr/bin/ruby
#
#
require 'open-uri'
require 'json'

url = 'https://ip-ranges.amazonaws.com/ip-ranges.json'
buffer = open(url).read
result = JSON.parse(buffer)

result.each do |elem|
  if elem['service'] == 'CLOUDFRONT'
    print "set_real_ip_from #{elem['ip_prefix']}\n"
  end
end

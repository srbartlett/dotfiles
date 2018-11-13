#!/usr/bin/env rackup
#\ -E deployment

use Rack::ContentLength

url = 'http://localhost:9292'
puts "Serving up #{Dir.pwd} on #{url} ..."
app = Rack::Directory.new Dir.pwd
run app
puts "Opening..."
sleep 0.2
system "open #{url}"

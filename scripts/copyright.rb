#!/usr/bin/env ruby
#encoding: UTF-8

require 'rubygems'

MIT_HEADER = <<MIT
//
// Copyright (c) 2012 ap4y (lod@pisem.net)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

MIT

def process_file(path)
  text = File.read(path)
  remove = ''
  text.each_line do |line|
    line_start = line.slice(0, 2)
    break if (line_start != '//' && line_start != "\n")
    remove << line
  end
  file_name = "//\n// #{File.basename(path)}\n"
  replace = text.sub(remove, file_name + MIT_HEADER)

  File.open(path, 'w') do |file|
    file.puts replace
  end
end

path = ARGV[0]
if !path
  puts "Path is not provided"
  exit
end

if File.directory?(path)
  Dir.glob(path + "**/*.{h,m}") do |file_path|
    process_file(file_path)
  end
else
  process_file(path)
end

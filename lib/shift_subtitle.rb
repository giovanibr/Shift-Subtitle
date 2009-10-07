#!/usr/bin/ruby
=begin
  Command line script that will read an SRT file, 
  and output another one with the new calculated times.

  ex: shift_subtitle --operation add --time 02,110 input_file output_file
=end

require 'optparse'
require "lib/srt_time"

# This hash will hold all of the options parsed
options = {}

optparse = OptionParser.new do|opts|
  # operation argument
  options[:operation]=""
  opts.on( '-o', '--operation OPERATION', 'Operation to perform [add,sub]' ) do |operation|
    operation.downcase!
    # check if operation is valid
    raise OptionParser::InvalidArgument, operation unless SrtTime.public_instance_methods.include? operation
    # save operation
    options[:operation]=operation    
  end

  # time argument
  options[:time]=""
  opts.on( '-t', '--time TIME', 'Time to shift [ss,mmm]' ) do |t|
    options[:time]=t
  end
  
  # This displays the help screen, all programs are
  # assumed to have this option.
  opts.on( '-h', '--help', 'Help' ) do
    puts opts
    exit
  end
end

# Parse the command-line
optparse.parse!

# try to open file to read
raise OptionParser::InvalidArgument, ARGV[0] unless File.exist? ARGV[0]
File.open(ARGV[0], 'r') do |f1|
  # create result file
  f2 = File.open(ARGV[1], 'w')
  while line = f1.gets
    # check if it's the line with times
    if line.include? '-->'
      times = line.split '-->'
      
      t1 = SrtTime.new(times[0].strip)
      # call operation for t1
      t1.send(options[:operation], options[:time])
      
      t2 = SrtTime.new(times[1].strip)
      # call operation for t2
      t2.send(options[:operation], options[:time])
      
      f2.puts("#{t1} --> #{t2}")
    else
      f2.puts(line)
    end
  end
  f2.close
end
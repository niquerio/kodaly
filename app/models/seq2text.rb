#! /usr/bin/env ruby
#
# usage: seq2text.rb [midi_file]
#
# This script translates a MIDI file into text. It reads the file into
# a MIDI::Sequence and calls to_s for each event.
#
# For a different (and more verbose) way to do the same thing, see
# reader2tex.rb.
#

# Start looking for MIDI module classes in the directory above this one.
# This forces us to use the local copy, even if there is a previously
# installed version out there somewhere.

require 'midilib/sequence'
require 'stringio'
require 'base64'

midi = Base64.decode64('TVRoZAAAAAYAAQACAeBNVHJrAAAAGwD/BAAA/1EDD0JAAP8DCEV4ZXJjaXNlAP8vAE1UcmsAAAAuAP8EFEFjb3VzdGljIEdyYW5kIFBpYW5vAJA8f4NggDx/AJA5f4NggDl/AP8vAA==')

# Read from MIDI file
seq = MIDI::Sequence.new()

#File.open(ARGV[0] || DEFAULT_MIDI_TEST_FILE, 'rb') do |file|
 StringIO.open(midi) do |io|
  # The block we pass in to Sequence.read is called at the end of every
  # track read. It is optional, but is useful for progress reports.
  seq.read(io) do |track, num_tracks, i|
#    puts "read track #{track ? track.name : ''} (#{i} of #{num_tracks})"
  end
end

seq.each do |track|
#  puts "*** track name \"#{track.name}\""
#  puts "instrument name \"#{track.instrument}\""
#  puts "#{track.events.length} events"
  track.each do |e|
    e.print_decimal_numbers = true # default = false (print hex)
    e.print_note_names = false # default = false (print note numbers)
    puts e
  end
end

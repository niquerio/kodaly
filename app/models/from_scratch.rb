#! /usr/bin/env ruby
#
# usage: from_scratch.rb
#
# This script shows you how to create a new sequence from scratch and save it
# to a MIDI file. It creates a file called 'from_scratch.mid'.

# Start looking for MIDI module classes in the directory above this one.
# This forces us to use the local copy, even if there is a previously
# installed version out there somewhere.
$LOAD_PATH[0, 0] = File.join(File.dirname(__FILE__), '..', 'lib')

require 'midilib/sequence'
require 'midilib/consts'
require 'stringio'
require 'base64'
include MIDI


def generate_midi (notes, name='Exercise', tempo=60)
  seq = Sequence.new()
  
  # Create a first track for the sequence. This holds tempo events and stuff
  # like that.
  track = Track.new(seq)
  seq.tracks << track
  track.events << Tempo.new(Tempo.bpm_to_mpq(tempo))
  track.events << MetaEvent.new(META_SEQ_NAME, name)
  
  # Create a track to hold the notes. Add it to the sequence.
  track = Track.new(seq)
  seq.tracks << track
  
  # Give the track a name and an instrument name (optional).
  track.instrument = GM_PATCH_NAMES[0]

  
  quarter_note_length = seq.note_to_delta('quarter')
  notes.each do |note|
    track.events << NoteOn.new(0, note, 127, 0)
    track.events << NoteOff.new(0, note, 127, quarter_note_length)
  end

  StringIO.open() do |io|
    seq.write(io) 
    return "data:;base64," + Base64.encode64(io.string).gsub(/\s+/, "")
  end
end

puts generate_midi([64,61]);

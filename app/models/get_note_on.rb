#! /usr/bin/env ruby

require 'midilib/sequence'
require 'midilib/io/midifile'
require 'stringio'
require 'base64'

midi = Base64.decode64('TVRoZAAAAAYAAQACAeBNVHJrAAAAGwD/BAAA/1EDD0JAAP8DCEV4ZXJjaXNlAP8vAE1UcmsAAAAuAP8EFEFjb3VzdGljIEdyYW5kIFBpYW5vAJA8f4NggDx/AJA5f4NggDl/AP8vAA==')

class TextTranslator < MIDI::IO::MIDIFile

  def initialize(seq, proc = nil)
    super()
    @seq = seq
    @track = nil
    @update_block = block_given?() ? Proc.new() : proc
    @notes = []
    
  end

  def start_track()
  end

  def note_on(chan, note, vel)
    @notes << note
  end

  def end_track()
    @update_block.call(@notes) if @update_block
  end
end

# ================================================================

seq = MIDI::Sequence.new()

seq.reader_class = TextTranslator

all_notes = []

StringIO.open(midi) do |io|
  seq.read(io) do |notes|
    all_notes = notes   
  end
end

puts "About to print some notes"
puts all_notes

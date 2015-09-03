ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'midilib/sequence'
require 'midilib/io/midifile'
require 'stringio'
require 'base64'

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

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def get_note_on(midi)
    
    midi.slice!('data:;base64,')
    midi = Base64.decode64(midi)

    seq = MIDI::Sequence.new()
    seq.reader_class = TextTranslator
    all_notes = []
    StringIO.open(midi) do |io|
      seq.read(io) do |notes|
        all_notes = notes   
      end
    end
   return all_notes 
  end
end

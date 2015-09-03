require 'midilib/sequence'
require 'midilib/consts'
require 'stringio'
require 'base64'
include MIDI

class QuestionFactory < ActiveRecord::Base
  def make_question
    if self.name === 'so_mi_1'
      return so_mi_1
    end
  end

private
  def so_mi_1
    question = Question.create(prompt: "Which is So Mi?", question_factory: self)
    
    wrong_interval = [0,1,2,5,6,7,8,9,10,11,12].sample
    max_interval = ''
    if wrong_interval > 3
      max_interval = wrong_interval
    else
      max_interval = 3
    end

    lowest_starting_note = 48 + max_interval
    starting_note = rand(lowest_starting_note..72)
    correct_notes = [lowest_starting_note, lowest_starting_note - 3]
    incorrect_notes = [lowest_starting_note, lowest_starting_note - wrong_interval]

    correct_midi_blob = generate_midi(correct_notes)
    incorrect_midi_blob = generate_midi(incorrect_notes)

    order = [0,1].shuffle
    Choice.create(midi_blob: correct_midi_blob, question: question, order:order.pop, correct:true)
    Choice.create(midi_blob: incorrect_midi_blob, question: question, order:order.pop,correct:false)
    
    return question

  end

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

end

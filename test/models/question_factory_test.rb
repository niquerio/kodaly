require 'test_helper'


class QuestionFactoryTest < ActiveSupport::TestCase
  def setup
    @question_factory = QuestionFactory.create(name: "so_mi_1")
    @question =  @question_factory.make_question
    @choices = Choice.where question: @question
    
  end
  test "Question should have correct prompt" do
      assert_equal "Which is So Mi?", @question.prompt
  end

  test "Question should have two associated choices" do
        assert_equal 2, @choices.size
  end

  test "One of question's choices should be correct" do
      correct_choices = 0 
      @choices.each do |choice|
        correct_choices = correct_choices + (choice.correct ? 1 : 0 )
      end
      assert_equal 1, correct_choices
  end
  test "Only two notes in each choice" do
    @choices.each do |choice| 
      notes = get_note_on(choice.midi_blob)
      assert_equal 2, notes.size
    end
  end
  #Correct one is correct
  test "Correct Choice is Correct and Incorrect is Incorrect" do

    @choices.each do |choice|
      if choice.correct
         correct_notes = get_note_on(choice.midi_blob)
         assert_equal 3, correct_notes[0] - correct_notes[1]
      else
         incorrect_notes = get_note_on(choice.midi_blob)
         refute_equal 3, incorrect_notes[0] - incorrect_notes[1]
      end
    end

  end
  
  test "Notes are in correct Range" do
    @choices.each do |choice| 
      notes = get_note_on(choice.midi_blob)
      notes.each do |note|
         assert note >= 48 
         assert note <= 72 
      end
    end
  end 

  test "Choices have same starting note" do
    first_notes = []
    @choices.each do |choice|
      notes = get_note_on(choice.midi_blob)
      first_notes << notes[0]
    end 
    assert first_notes[0] === first_notes[1]
  end

  test "Incorrect Choice has appropriate interval" do
    @choices.each do |choice|
      if !choice.correct
        notes = get_note_on(choice.midi_blob)
        interval = notes[0] - notes[1]
        appropriate_intervals = [0,1,2,5,6,7,8,9,10,11,12]
        assert appropriate_intervals.include? interval
      end
    end
  end

  test "Generates Different Questions Each Time" do
    new_question = @question_factory.make_question
    refute_equal @question, new_question
    refute_equal @choices, (Choice.where question: new_question)
  end

  test "All potential incorrect intervals are covered and incorrect intervals are appropriate" do
    appropriate_intervals = [0,1,2,5,6,7,8,9,10,11,12]
    intervals_not_covered = [0,1,2,5,6,7,8,9,10,11,12]
    (0..100).each do 
      question = @question_factory.make_question
      choices = Choice.where question: question
      choices.each do |choice|
        if !choice.correct
          notes = get_note_on(choice.midi_blob)
          interval = notes[0] - notes[1]
          assert appropriate_intervals.include? interval
          intervals_not_covered.delete interval
        end
      end
    end    
    assert_empty intervals_not_covered
  end
end

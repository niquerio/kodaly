require 'test_helper'

class AnsweredQuestionTest < ActiveSupport::TestCase
  def setup
    @question = Question.create(prompt: "I am a prompt")
    @choice1 = Choice.create(midi_blob: "awlfkja;wlfekja;welfajw;eoij", question:@question)
    @choice2 = Choice.create(midi_blob: "awlfkja;wlfekja;welfajw;eoij", question:@question)
    @question.update(correct_choice: @choice2)

    @wrong_answer = AnsweredQuestion.new(choice: @choice1, question:@question)
    @correct_answer = AnsweredQuestion.new(choice: @choice2, question:@question)
    
  end

  test "answered question should return correct result" do
      assert @correct_answer.is_choice_correct
      refute @wrong_answer.is_choice_correct
  end 
end

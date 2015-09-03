require 'test_helper'

class AnsweredQuestionTest < ActiveSupport::TestCase
  def setup
    @question = Question.create(prompt: "I am a prompt")
    @choice1 = Choice.create(midi_blob: "awlfkja;wlfekja;welfajw;eoij", question:@question, correct:false, order:0)
    @choice2 = Choice.create(midi_blob: "awlfkja;wlfekja;welfajw;eoij", question:@question, correct:true, order:1)
    @user = User.create(name: "Name")

    @wrong_answer = AnsweredQuestion.new(choice: @choice1, user: @user)
    @correct_answer = AnsweredQuestion.new(choice: @choice2, user: @user)
    
  end

  test "answered question should return correct result" do
      assert @correct_answer.is_choice_correct
      refute @wrong_answer.is_choice_correct
  end 

end

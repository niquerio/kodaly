require 'test_helper'

class QuestionFactoriesControllerTest < ActionController::TestCase
  def setup
    @question_factory = QuestionFactory.new(name: "so_mi_1")
    @question_factory.save
    @question = Question.new(prompt: "Which is So Mi?")
    @question.save
    @choice = Choice.new(midi_blob:"blahblahlblah", question:@question, correct:true)
    @choice.save
  end

  test "should get show" do
    get :show, :id => @question_factory.id, :format => :json
    assert_response :success
  end
end

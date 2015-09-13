Kodaly.module("QuestionApp.Show", function(Show,Kodaly, Backbone, Marionette, $, _){
  Show.Controller = {
    showQuestion: function(questionFactory_id){
        var user_id = 1
        var fetchingQuestion = Kodaly.request('newQuestion:entities',questionFactory_id) 
        var fetchingScore = Kodaly.request('score:entities', user_id, questionFactory_id)
        
        var questionLayout = new Show.Layout();
        
        $.when(fetchingQuestion, fetchingScore).done(function(question, score){
          var questionShowView = new Show.Question({ model: question });
          var scoreView = new Show.Score({model: score});
          
          questionLayout.on('show', function(){
            questionLayout.questionRegion.show(questionShowView);
            questionLayout.scoreRegion.show(scoreView);
          });
          
          questionShowView.on("question:submit", function(answered_question){
            $.getJSON("app/check_answer", answered_question, function(data){
              questionShowView.triggerMethod('question:result', data);
            })
          });

          questionShowView.on("question:new", function(){
            fetchingQuestion = Kodaly.request('newQuestion:entities',questionFactory_id) 
            fetchingScore = Kodaly.request('score:entities', user_id, questionFactory_id)
            $.when(fetchingQuestion, fetchingScore).done(function(new_question,new_score){
              questionShowView.triggerMethod('question:rerender',new_question);
              scoreView.triggerMethod('score:rerender',new_score);
            });
            
          });
          Kodaly.regions.body.show(questionLayout);
        });

    },
    
    
  }
});

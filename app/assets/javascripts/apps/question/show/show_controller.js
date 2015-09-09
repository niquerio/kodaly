Kodaly.module("QuestionApp.Show", function(Show,Kodaly, Backbone, Marionette, $, _){
  Show.Controller = {
    showQuestion: function(questionFactory_id){
        var fetchingQuestion = Kodaly.request('newQuestion:entities',questionFactory_id) 
        $.when(fetchingQuestion).done(function(question){
          var questionShowView = new Show.Question({ model: question });
          
          Kodaly.regions.body.show(questionShowView);
          
          questionShowView.on("question:submit", function(answered_question){
            $.getJSON("app/check_answer", answered_question, function(data){
              questionShowView.triggerMethod('question:result', data);
            })
          });

          questionShowView.on("question:new", function(){
            fetchingQuestion = Kodaly.request('newQuestion:entities',questionFactory_id) 
            $.when(fetchingQuestion).done(function(new_question){
              questionShowView.triggerMethod('question:rerender',new_question);
            });
            
          });
        });

    },
    
    
  }
});

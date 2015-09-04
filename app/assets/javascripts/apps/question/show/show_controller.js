Kodaly.module("QuestionApp.Show", function(Show,Kodaly, Backbone, Marionette, $, _){
  Show.Controller = {
    showQuestion: function(){
        var question = Kodaly.request('newQuestion:entities',1) 
        var questionShowView = new Show.Question({ model: question });
        Kodaly.regions.body.show(questionShowView);
        
        questionShowView.on("question:submit", function(answered_question){
          $.getJSON("app/check_answer", answered_question, function(data){
            questionShowView.triggerMethod('question:result', data);
          })
        });

        questionShowView.on("question:new", function(){
          question = Kodaly.request('newQuestion:entities',1) 
          questionShowView.model = question
          Kodaly.regions.body.show(questionShowView, {forceShow: true});
          
        });

    },
    
    
  }
});

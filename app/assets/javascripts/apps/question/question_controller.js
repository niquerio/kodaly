Kodaly.module("QuestionApp.Show", function(Show,Kodaly, Backbone, Marionette, $, _){
  Show.Controller = {
    showQuestion: function(){
        var question = Kodaly.request('newQuestion:entities',1) 
        var questionShowView = new Show.Question({ model: question });
        Kodaly.regions.body.show(questionShowView);
    },
  }
});

Kodaly.module("QuestionApp", function(QuestionApp, Kodaly, Backbone, Marionette, $, _){
  QuestionApp.Router = Marionette.AppRouter.extend({
    appRoutes: {
      "test/:fragment": "showQuestion",
    }
  });

  var API = {
    showQuestion: function(fragment){
        if(fragment === 'so-mi-1'){
          QuestionApp.Show.Controller.showQuestion(1);
        }
    }
  };
  Kodaly.on("lesson:test:show", function(fragment, type){
    if(fragment === 'so-mi-1'){Kodaly.navigate(type + '/' + fragment);}
    API.showQuestion(fragment);
  });  
  Kodaly.on("lesson:song:show", function(fragment, type){
    console.log("lesson:song:show triggered")
  });  

  QuestionApp.on("start", function(){
    new QuestionApp.Router({
      controller: API
    });
  });
});

Kodaly.module("Lesson", function(Lesson, Kodaly, Backbone, Marionette, $, _){
  Lesson.Router = Marionette.AppRouter.extend({
    appRoutes: {
      "lessons": "listLessons",
    }
  });

  var API = {
    listLessons: function(){
      Lesson.List.Controller.listLessons();
      Kodaly.execute("set:active:header", "lessons")
    }
  };

  Kodaly.on("lessons:list", function(){
    Kodaly.navigate('lessons');
    API.listLessons();
  });

  Lesson.on("start", function(){
    new Lesson.Router({
      controller: API
    });
  });
});

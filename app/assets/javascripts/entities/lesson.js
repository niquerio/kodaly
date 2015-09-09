Kodaly.module("Entities", function(Entities, Kodaly, Backbone, Marionette, $, _){
  Entities.Lesson = Backbone.Model.extend({});
  Entities.Lessons = Backbone.Collection.extend({
    model: Entities.Lesson,
  }); 

  Entities.Lesson_Branch = Backbone.Model.extend({
    defaults:{
      lessons: null
    },
    initialize: function(){
      var lessons = this.get('lessons');
      this.set('lessons', new Entities.Lessons(lessons));
    },
  });

  Entities.Lesson_Branches = Backbone.Collection.extend({
    model: Entities.Lesson_Branch,
  }); 

  var lessons;
  var initialize_lessons = function(){
    lessons = new Entities.Lesson_Branches([
      { 
        row: 1,
        lessons: [
          {
            order: 1,
            title: "Song: Bee Bee",
            type: "song",
            fragment: "bee-bee",
            category: "video"
          },
        ],
      },
      { 
        row: 2,
        lessons: [
          {
            order: 1,
            title: "So-Mi Level 1",
            type: "test",
            fragment: "so-mi-1",
            category: "pitch"
          },
          {
            order: 2,
            title: "Higher / Lower",
            type: "test",
            fragment: "higher-lower",
            category: "pitch"
          },
        ],
      },
    ]);
  }

  var API = {
    getLessonEntities: function(){
      if(lessons === undefined){
        initialize_lessons();
      }
      return lessons;
    }
  }

  Kodaly.reqres.setHandler("lesson:entities", function(){
    return API.getLessonEntities();
  });
});

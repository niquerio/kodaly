Kodaly.module("Lesson.List", function(List, Kodaly, Backbone, Marionette, $, _){

  List.Lesson = Marionette.ItemView.extend({
    tagName: 'li',
    template: 'lesson/lesson_view',
    triggers: {
      'click a.test' : 'lesson:test:show',
      'click a.song' : 'lesson:song:show',
    },
  });

  List.Branch = Marionette.CompositeView.extend({
      template: 'lesson/branch_view',
      childView: List.Lesson,
      childViewContainer: ".list-inline",
      initialize: function(){
        this.collection = this.model.get('lessons')
      },
  }); 

  List.Branches = Marionette.CompositeView.extend({
    template: 'lesson/branches_view',
    childView: List.Branch,
    childViewContainer: "#tree",
  }); 
});

Kodaly.module("Lesson.List", function(List,Kodaly, Backbone, Marionette, $, _){
  List.Controller = {
    listLessons: function(){
      var lessons = Kodaly.request('lesson:entities');
      var lessonListView = new List.Branches({ collection: lessons });
      Kodaly.regions.body.show(lessonListView);

      lessonListView.on('childview:childview:lesson:test:show', function(childView, args){
        var fragment = args.model.get('fragment');
        var type = args.model.get('type');
        Kodaly.trigger('lesson:test:show', fragment, type)
      });
      lessonListView.on('childview:childview:lesson:song:show', function(childView, args){
        var fragment = args.model.get('fragment');
        var type = args.model.get('type');
        Kodaly.trigger('lesson:song:show', fragment, type)
        console.log('lessonListView lesson:song:show triggered')
      });
    },
  };
});

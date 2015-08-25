Kodaly.Routers.Main = Marionette.AppRouter.extend({
    routes: {
        "" : "redirectToMain",
        "lessons": "lessons",
    },
    redirectToMain : function(){
        console.log('Redirected to Main');
        Backbone.history.navigate('lessons', {trigger: true, replace: true });
    },
   lessons: function(){
        //May have problems with zombie views.
        var question = new Kodaly.Models.Question({id:1});
        question.fetch({
           success: function(data){
              var view = new Kodaly.Views.Question({ model: question });
              view.render();
           } 
        });
   },

});



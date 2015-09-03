Marionette.Renderer.render = function(template, data){
  return JST[template](data);
};

window.Kodaly =  (function(){
    var Application = Marionette.Application.extend({
      Models: {},
      Collections: {},
      Views: {},
      Routers: {},
      Controllers: {},
    
    });
    var app = new Application();

    var RootView = Marionette.LayoutView.extend({
      el: "#app-container",
      regions: {
        body: '[data-region=body]',
      }
    });

    app.regions = new RootView();



    app.on('start', function(){
      Kodaly.QuestionApp.Show.Controller.showQuestion();
      //var router = new Kodaly.Routers.Main();
      //var lessonsRouter = new Kodaly.Routers.Lessons({controller: Kodaly.Controllers.Lessons});
      //  

      //Backbone.history.start();
    });

    return app;
})();





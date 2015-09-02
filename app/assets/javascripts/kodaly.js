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
      regions: {
        body: '[data-region=body]',
      }
    });

    app.rootView = new RootView

    app.addRegions({
    });


    app.on('start', function(){
      var router = new Kodaly.Routers.Main();
      var lessonsRouter = new Kodaly.Routers.Lessons({controller: Kodaly.Controllers.Lessons});
        

      Backbone.history.start();
    });

    return app;
})();



//{
//  initialize: function() {
//      this.app = new this.Application();
//  },
//};
//
//(function(){
//    Kodaly.initialize();
//})();


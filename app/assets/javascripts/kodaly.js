Marionette.Renderer.render = function(template, data){
  return JST[template](data);
};

window.Kodaly =  (function(){
    var Application = Marionette.Application.extend({
      Models: {},
      Collections: {},
      Views: {},
      Routers: {},
    
    });
    var app = new Application();

      app.addRegions({
          body: '[data-region=body]',
      });


      app.on('start', function(){
        var router = new Kodaly.Routers.Main();

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


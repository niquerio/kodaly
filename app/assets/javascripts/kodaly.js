Marionette.Renderer.render = function(template, data){
  return JST[template](data);
};

window.Kodaly =  (function(){
    var app = new Marionette.Application();

    app.navigate = function(route,  options){
      options || (options = {});
      Backbone.history.navigate(route, options);
    };
    
    app.getCurrentRoute = function(){
      return Backbone.history.fragment
    };

    var RootView = Marionette.LayoutView.extend({
      el: "#app-container",
      regions: {
        header: '[data-region=header]',
        body: '[data-region=body]',
      }
    });

    app.regions = new RootView();



    app.on('start', function(){
      if(Backbone.history){
        if(!Backbone.history.started){
          Backbone.history.start();
          Backbone.history.started = true;
        }
        if(this.getCurrentRoute() === ""){
          Kodaly.trigger("lessons:list");
        }
      }
    });

    return app;
})();





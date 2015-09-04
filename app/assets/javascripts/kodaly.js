Marionette.Renderer.render = function(template, data){
  return JST[template](data);
};

window.Kodaly =  (function(){
    var app = new Marionette.Application();

    var RootView = Marionette.LayoutView.extend({
      el: "#app-container",
      regions: {
        body: '[data-region=body]',
      }
    });

    app.regions = new RootView();



    app.on('start', function(){
      Kodaly.QuestionApp.Show.Controller.showQuestion();
    });

    return app;
})();





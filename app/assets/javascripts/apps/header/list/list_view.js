Kodaly.module("HeaderApp.List", function(List, Kodaly, Backbone, Marionette, $, _){
  List.Header = Marionette.ItemView.extend({
    template: "header/link",
    tagName: "li",
    triggers: {
      "click" : "navigate",
    },
    onRender: function(){
      if(this.model.selected){
        this.$el.addClass("active");
      }
    },
  });

  List.Headers = Marionette.CompositeView.extend({
    template: "header/composite_view",
    className: "navbar navbar-inverse navbar-fixed-top",
    childView: List.Header,
    childViewContainer: "ul",
    triggers: {
      "click a.brand" : "brand:clicked",
    }
  });
});

Kodaly.module("HeaderApp.List", function(List,Kodaly, Backbone, Marionette, $, _){
  List.Controller = {
    listHeader: function(){
      var links = Kodaly.request("header:entities");
      var headers = new List.Headers({collection: links});
      
      headers.on("brand:clicked", function(childView, args){
        Kodaly.trigger("lessons:list");
      });
      headers.on("childview:navigate", function(childView, args){
        var trigger = args.model.get("navigationTrigger");
        Kodaly.trigger(trigger)
        
      });
      Kodaly.regions.header.show(headers);
      
    },
    setActiveHeader: function(headerUrl){
      var links = Kodaly.request("header:entities");
      var headerToSelect = links.find(function(header){
        return header.get("url") === headerUrl;
      }); 
      headerToSelect.select();
      links.trigger("reset");
    }

     
  };
});

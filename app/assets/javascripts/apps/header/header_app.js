Kodaly.module("HeaderApp", function(Header, Kodaly, Backbone, Marionette, $, _){
  var API = {
    listHeader: function(){
      Header.List.Controller.listHeader();
    }
  }; 
  Kodaly.commands.setHandler("set:active:header", function(name){
    Kodaly.HeaderApp.List.Controller.setActiveHeader(name);
  });

  Header.on("start", function(){
    API.listHeader();
  });
});

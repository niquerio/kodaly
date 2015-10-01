Kodaly.module("Entities", function(Entities, Kodaly, Backbone, Marionette, $, _){
  Entities.User = Backbone.Model.extend({
  });
  var API = {
    initializeUser: function(user){
      Entities.user = new Entities.User(user);
      return Entities.user;
    }, 
    getUser: function(){
      return Entities.user;
    },
  };

  Kodaly.commands.setHandler("initialize:user:entities",  function(user){
      return API.initializeUser(user);
  });
  Kodaly.reqres.setHandler("user:entities",  function(){
      return API.getUser();
  });
});

Kodaly.module("Entities", function(Entities, Kodaly, Backbone, Marionette, $, _){
  Entities.Score = Backbone.Model.extend({
    defaults: {
      complete: false,
      highest_streak: 0,
      current_streak: 0,
      question_factory_id: null,
      user_id: null
    },
    url: function(){
      return '/app/users/' + encodeURIComponent(this.attributes.user_id) + 
        '/question_factories/' + encodeURIComponent(this.attributes.question_factory_id) +'/score'
    },
    
  });
  Entities.Scores = Backbone.Collection.extend({
    model: Entities.Score,
  }); 

  var scores;
  //fake data is fake
  var initialize_scores = function(){
    scores = new Entities.Scores([
      {
        id: 1,
        complete: false, 
        highest_streak: 3,
        current_streak: 2,
      },
      {
        id: 2,
        complete: true, 
        highest_streak: 5,
        current_streak: 5,
      },
    ]);
  };

  var API = {
    getScoreEntities: function(user_id, question_factory_id){
      var score = new Entities.Score({user_id: user_id, question_factory_id: question_factory_id}); 
      var defer = $.Deferred();
      score.fetch({
        success: function(data){
          defer.resolve(data);
        },
        error: function(data){
          defer.resolve()
         
        },
      });
      var promise = defer.promise();
      return promise
    },
  };

  Kodaly.reqres.setHandler("score:entities", function(user_id, question_factory_id){
    return API.getScoreEntities(user_id, question_factory_id);
  });
});

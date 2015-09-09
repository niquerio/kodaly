Kodaly.module("Entities", function(Entities, Kodaly, Backbone, Marionette, $, _){
  Entities.Question = Backbone.Model.extend({
    defaults: {
        prompt: 'Question',
        choices: null
    },
    initialize: function(){
      var choices = this.get('choices');
      this.set('choices', new Entities.Choices(choices));
      this.get('choices').forEach(function(model, index){
       model.set('name',String.fromCharCode('A'.charCodeAt() + index)); 
      });
    },
    urlRoot: "/question_factories/",
  });

  Entities.Choice = Backbone.Model.extend({
    defaults: {
        id: '',
        midi_blob: '',
    },
    initialize: function(){
    },
  });

  Entities.Choices = Backbone.Collection.extend({
    model: Entities.Choice,
});

  var API = {
    getNewQuestionEntities: function(question_factory_id){
      var question = new Entities.Question({id:question_factory_id});
      var defer = $.Deferred();
      question.fetch({
        success: function(data){
          data.initialize();
          defer.resolve(data);
        }
      }); 
      var promise = defer.promise();
      return promise;
    }
  }

  Kodaly.reqres.setHandler("newQuestion:entities", function(question_factory_id){
      return API.getNewQuestionEntities(question_factory_id);
  });
});

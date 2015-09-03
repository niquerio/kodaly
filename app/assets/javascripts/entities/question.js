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

  
  var question;

  var init_question = function(){
    question = new Entities.Question(
    {"prompt":"Which is So Mi?",
      "id":216,
      "choices":[
        {"midi_blob":"data:;base64,TVRoZAAAAAYAAQACAeBNVHJrAAAAGwD/BAAA/1EDD0JAAP8DCEV4ZXJjaXNlAP8vAE1UcmsAAAAuAP8EFEFjb3VzdGljIEdyYW5kIFBpYW5vAJAzf4NggDN/AJAyf4NggDJ/AP8vAA==",
        "id":429},
        {"midi_blob":"data:;base64,TVRoZAAAAAYAAQACAeBNVHJrAAAAGwD/BAAA/1EDD0JAAP8DCEV4ZXJjaXNlAP8vAE1UcmsAAAAuAP8EFEFjb3VzdGljIEdyYW5kIFBpYW5vAJAzf4NggDN/AJAwf4NggDB/AP8vAA==","id":428}]}
    );
  }
  
  var API = {
    getNewQuestionEntities: function(question_factory_id){
      //problem is that fetch is too slow. :(
      if(question === undefined){
        init_question();
      }
      return question;
    }
  }

  Kodaly.reqres.setHandler("newQuestion:entities", function(question_factory_id){
      return API.getNewQuestionEntities(question_factory_id);
  });
});

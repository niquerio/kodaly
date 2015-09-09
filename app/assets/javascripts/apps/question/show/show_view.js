Kodaly.module("QuestionApp.Show", function(Show, Kodaly, Backbone, Marionette, $, _){

  Show.Choice = Marionette.ItemView.extend({
    className: 'radio-inline',
    events: {
        'click .play' : 'play', 
    },
    template: 'choice/view',

    
    play: function(){
       MIDI.Player.loadFile(this.model.get('midi_blob'), function(){
           MIDI.Player.resume();
       }); 
    }
  });

  Show.Question = Marionette.CompositeView.extend({
    template: 'question/view',
    childView: Show.Choice,
    childViewContainer: ".form-group",
    triggers: {
        "click .get-next-question" : "question:new",
    },
    events: {
        "click .submit-answer" : "submit",
    },
    initialize: function(){
        this.collection = null;
        this.collection = this.model.get('choices');
        
    },
    submit: function(event){
        event && event.preventDefault(); 
        var selected = $('input[name=choice]:checked', '#choice-list').val()
            var answered_question = {
               "answered_question": { 
                "user_id": 1, //Hardcoded For now.
                "choice_id": selected
               }
            };
        if(!selected){
            var alert = $('<div>')
                .addClass("alert alert-danger")
                .attr('role',"alert")
                .html('Select Something!');
            this.$el.prepend(alert)
        }else{
            this.trigger('question:submit',answered_question);    
       }
    },
    onQuestionResult: function(data){ 
      if(data.correct){
         var alert = $('<div>')
                .addClass("alert alert-success")
                .attr('role',"alert")
                .html('Correct!');
         this.$el.append(alert)
      }else{
         var alert = $('<div>')
            .addClass("alert alert-danger")
            .attr('role',"alert")
            .html('Incorrect!');
         this.$el.append(alert)
      }
      $('.form-group').wrap("<fieldset disabled></fieldset>");
      $('.submit-answer').removeClass("submit-answer").addClass('get-next-question').html('Next Question');
    },

    onQuestionRerender: function(model){
      this.model = model;
      this.initialize();
      this.render();
    },
  });
});

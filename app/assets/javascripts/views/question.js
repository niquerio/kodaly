Kodaly.Views.Question = Marionette.CompositeView.extend({
    el: '#question',
    template: 'question/view',
    childView: Kodaly.Views.Choice,
    childViewContainer: ".form-group",
    events: {
        "click .submit-answer" : "submit",
        "click .get-next-question" : "nextQuestion",
    },
    initialize: function(){
        this.collection = null;
        this.collection = this.model.get('choices');
        
        //Turn choices into collection of choices
//        if(!this.collection){
//          this.collection = new Kodaly.Collections.Choices
//        }
//        name = 'A'
//        for( var key in this.model.get('choices')){
//            var choice = this.model.attributes.choices[key];
//            choice.name = name;
//            this.collection.add(choice);
//            name = String.fromCharCode(name.charCodeAt() + 1)
//            
//        }
    },
    submit: function(event){
        event && event.preventDefault(); 
        var selected = $('input[name=choice]:checked', '#choice-list').val()
            var answered_question = {
               "answered_question": { 
                "user_id": Kodaly.user.get("id"),
                "choice_id": selected
               }
            };
            
        var self = this;
        if(!selected){
            var alert = $('<div>').addClass("alert alert-danger").attr('role',"alert").html('Select Something!');
            this.$el.prepend(alert)
        }else{
            $.getJSON("app/check_answer", answered_question, function(data){
                if(data.correct){
                   var alert = $('<div>').addClass("alert alert-success").attr('role',"alert").html('Correct!');
                   self.$el.append(alert)
                }else{
                   var alert = $('<div>').addClass("alert alert-danger").attr('role',"alert").html('Incorrect!');
                   self.$el.append(alert)
                }
                $('.form-group').wrap("<fieldset disabled></fieldset>");
                $('.submit-answer').removeClass("submit-answer").addClass('get-next-question').html('Next Question');
               Kodaly.user.fetch();
            }
                    
        )}
    },
    nextQuestion: function(){
        event && event.preventDefault(); 
        this.model = Kodaly.request('newQuestion:entities',1)
        this.initialize();
        this.render();
        //this.collection.reset();
        //this.model.set('id',1);
        //var self = this;
        //this.model.fetch({
        //   success: function(data){
        //      self.model = data;
        //      self.initialize();
        //      self.render();
        //   } 
        //});
    },
});

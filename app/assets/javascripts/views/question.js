Kodaly.Views.Question = Backbone.View.extend({
    el: '#question',
    events: {
        "click .submit-answer" : "submit",
        "click .get-next-question" : "nextQuestion",
    },
    initialize: function(){
        //Turn choices into collection of choices
        this.choices = new Kodaly.Collections.Choices
        for( var key in this.model.get('choices')){
            this.choices.add({'name': key, 'midi_blob': this.model.attributes.choices[key]});
            
        }
    },
    submit: function(event){
        event && event.preventDefault(); 
        var selected = $('input[name=choice]:checked', '#choice-list').val()
        var self = this;
        if(!selected){
            var alert = $('<div>').addClass("alert alert-danger").attr('role',"alert").html('Select Something!');
            this.$el.prepend(alert)
        }else{
            $.getJSON("test/answer", selected, function(data){
                if(data.correct){
                   var alert = $('<div>').addClass("alert alert-success").attr('role',"alert").html('Correct!');
                   self.$el.append(alert)
                }else{
                   var alert = $('<div>').addClass("alert alert-danger").attr('role',"alert").html('Incorrect!');
                   self.$el.append(alert)
                }
                $('.form-group').wrap("<fieldset disabled></fieldset>");
                $('.submit-answer').removeClass("submit-answer").addClass('get-next-question').html('Next Question');
            }
                    
        )}
    },
    nextQuestion: function(){
        event && event.preventDefault(); 
        alert('Next Question!');
    },
    render: function() {
        this.$el.html(JST['question/view']({ model: this.model }));
        this.renderChoices();
        return this;
    },
    renderOneChoice: function(choice){
        var view = new Kodaly.Views.Choice({ model: choice});
        $('.form-group').append(view.render().el);
    },
    renderChoices: function(){
       this.choices.each(this.renderOneChoice, this); 
    },
});

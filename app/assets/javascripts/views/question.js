Kodaly.Views.Question = Backbone.View.extend({
    el: '#question',
    events: {
        "click button" : "submit",
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
        if(!selected){
            var alert = $('<div>').addClass("alert alert-danger").attr('role',"alert").html('Select Something!');
            this.$el.prepend(alert)
        }else{
            var alert = $('<div>').addClass("alert alert-success").attr('role',"alert").html("You've selected " + selected);
            this.$el.prepend(alert)
        }
    },
    render: function() {
        this.$el.html(JST['question/view']({ model: this.model }));
        this.renderChoices();
        return this;
    },
    renderOneChoice: function(choice){
        var view = new Kodaly.Views.Choice({ model: choice});
        $('button').before(view.render().el);
    },
    renderChoices: function(){
       this.choices.each(this.renderOneChoice, this); 
    },
});

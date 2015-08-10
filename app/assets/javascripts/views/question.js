Kodaly.Views.Question = Backbone.View.extend({
    el: '#question',
    initialize: function(){
        //Turn choices into collection of choices
        this.choices = new Kodaly.Collections.Choices
        for( var key in this.model.get('choices')){
            this.choices.add({'name': key, 'midi_blob': this.model.attributes.choices[key]});
            
        }
    },
    render: function() {
        this.$el.html(JST['question/view']({ model: this.model }));
        this.renderChoices();
        return this;
    },
    renderOneChoice: function(choice){
        var view = new Kodaly.Views.Choice({ model: choice});
        $('#choice-list').append(view.render().el);
    },
    renderChoices: function(){
       this.choices.each(this.renderOneChoice, this); 
    },
});

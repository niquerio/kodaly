Kodaly.Views.Choice = Backbone.View.extend({
    tagname: 'li',
    events: {
        'click .play' : 'play', 
    },
    render: function() {
        this.$el.html(JST['choice/view']({ model: this.model }));
        return this;
    },
    play: function(){
       MIDI.Player.loadFile(this.model.get('midi_blob'), function(){
           MIDI.Player.resume();
       }); 
    }
});

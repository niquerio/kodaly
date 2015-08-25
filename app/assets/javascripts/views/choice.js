Kodaly.Views.Choice = Marionette.ItemView.extend({
    className: 'radio-inline',
    events: {
        'click .play' : 'play', 
    },
    template: 'choice/view',
    
    //render: function() {
    //    this.$el.html(JST['choice/view']({ model: this.model }));
    //    return this;
    //},
    play: function(){
       MIDI.Player.loadFile(this.model.get('midi_blob'), function(){
           MIDI.Player.resume();
       }); 
    }
});

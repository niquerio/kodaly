Kodaly.Models.QuestionFactory = Backbone.Model.extend({
    defaults: {
        name: 'Exercise',
        completed: false,
        highest_streak: 0,
        current_streak: 0,
    },
    initialize: function(){
    },
});

Kodaly.Models.Question = Backbone.Model.extend({
    defaults: {
        prompt: 'Question',
        choices: new Object,
    },
    initialize: function(){
    },
    urlRoot: "/question_factories/",
});

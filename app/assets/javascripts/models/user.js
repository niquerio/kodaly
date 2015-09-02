Kodaly.Models.User = Backbone.Model.extend({
    defaults: {
        name: 'Name',
        question_factories: new Object,
    },
    initialize: function(){
    },
    urlRoot: '/users/'
});

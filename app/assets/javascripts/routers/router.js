Kodaly.Routers.Main = Marionette.AppRouter.extend({
    routes: {
        "" : "redirectToMain",
        "lessons": "lessons",
    },
    redirectToMain : function(){
        console.log('Redirected to Main');
        Backbone.history.navigate('lessons', {trigger: true, replace: true });
    },

});



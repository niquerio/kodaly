Kodaly.Controllers.Lessons = {
   lessons: function(){
        //get rid of old stuff. Is this a problem?
       // Kodaly.body.close();
        this.data = this.view = null;

        if(!Kodaly.user){
          Kodaly.user = new Kodaly.Models.User({id:1}) //Hardcoded User 1
          Kodaly.user.fetch();
        }
        var question = new Kodaly.Models.Question({id:1});
        question.fetch({
           success: function(data){
              this.view = new Kodaly.Views.Question({ model: question });
              view.render();
           } 
        });
   },
   hide: function() {
   },
}

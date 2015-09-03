Kodaly.Controllers.Lessons = {
   lessons: function(){
        //get rid of old stuff. Is this a problem?
        this.data = this.view = null;

        if(!Kodaly.user){
          Kodaly.user = new Kodaly.Models.User({id:1}) //Hardcoded User 1
          Kodaly.user.fetch();
        }
        var question = Kodaly.request('newQuestion:entities',1) 
        this.view = new Kodaly.Views.Question({ model: question });
        this.view.render();
   },
}

describe('User Model', function(){
    it("Has expected default values", function(){
        var user = new Kodaly.Models.User()
        expect(user.get('name')).toMatch('Name')
        expect($.isEmptyObject(user.get('question_factories'))).toBe(true)
    });
});

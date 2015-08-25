describe('Model', function(){
    it("Has expected default values", function(){
        var question = new Kodaly.Models.Question()
        expect(question.get('prompt')).toMatch('Question')
        expect($.isEmptyObject(question.get('choices'))).toBe(true)
    });
});

describe('Question Factory Model', function(){
    it("Has expected default values", function(){
        var qf = new Kodaly.Models.QuestionFactory()
        expect(qf.get('name')).toMatch('Exercise')
        expect(qf.get('completed')).toBe(false)
        expect(qf.get('highest_streak')).toBe(0)
        expect(qf.get('current_streak')).toBe(0)
    });
});

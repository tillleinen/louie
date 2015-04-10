chai = require('chai')
expect = chai.expect
assert = require('assert')
Louie = require('../index.js')


describe 'Louie', ->
    louie = null

    beforeEach ->
        louie = new Louie()

    it 'should be a Louie instance', ->
        expect(louie).to.be.an.instanceof Louie

    it 'should not be running for a new instance', ->
        expect(louie.isRunning()).to.be.false

    it 'should be running after started', ->
        louie.start()
        expect(louie.isRunning()).to.be.true
        
    it 'should not be running after stopped', ->
        louie.start()
        louie.stop()
        expect(louie.isRunning()).to.be.false

    describe 'tasks', ->
        it 'should have an empty task list', ->
            tasks = louie.getTasks()
            expect(tasks).to.be.a('Array')
            expect(tasks).to.be.empty

        it 'should be able to add tasks', ->
            louie.addTask
                task: ->

            tasks = louie.getTasks()
            expect(tasks).to.have.length(1)

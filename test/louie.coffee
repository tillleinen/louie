chai = require('chai')
expect = chai.expect
assert = require('assert')
Louie = require('../index.js')


describe 'Louie', ->
    louie = null

    beforeEach ->
        louie = new Louie()

    afterEach ->
        louie.stop()

    it 'should be a Louie instance', ->
        expect(louie).to.be.an.instanceof Louie

    describe 'loop', ->
        it 'should not be running initially', ->
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

        it 'should call the task after 1000ms', (done) ->
            timeNow = Date.now()
            timeExpectedAfterFinishing = timeNow + 1000

            louie.addTask
                task: ->
                    expect(Date.now()).to.be
                        .closeTo(timeExpectedAfterFinishing, 100)
                    done()

            louie.start()

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
                        .closeTo(timeExpectedAfterFinishing, 50)
                    done()

            louie.start()

        it 'should allow custom timeouts per task', (done) ->
            firstTimeout = 500
            secondTimeout = 100
            thirdTimeout = 1000

            timeNow = Date.now()
            timeExpectedAfterFinishingFirst = timeNow + firstTimeout
            timeExpectedAfterFinishingSecond = 
                timeExpectedAfterFinishingFirst + secondTimeout
            timeExpectedAfterFinishingThird = 
                timeExpectedAfterFinishingSecond + thirdTimeout

            louie.addTask
                timeout: firstTimeout
                task: ->
                    expect(Date.now()).to.be
                        .closeTo(timeExpectedAfterFinishingFirst, 50)

            louie.addTask
                timeout: secondTimeout
                task: ->
                    expect(Date.now()).to.be
                        .closeTo(timeExpectedAfterFinishingSecond, 50)

            louie.addTask
                timeout: thirdTimeout
                task: ->
                    expect(Date.now()).to.be
                        .closeTo(timeExpectedAfterFinishingThird, 50)
                    done()

            tasks = louie.getTasks()
            expect(tasks).to.have.length(3)

            louie.start()


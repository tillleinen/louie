lolex = require("lolex")
chai = require('chai')
expect = chai.expect
assert = require('assert')
Louie = require('../index.js')

TIME_PRECISION = 50

describe 'Louie', ->
    louie = null
    clock = null

    beforeEach ->
        louie = new Louie()
        clock = lolex.install()

    afterEach ->
        louie.stop()
        clock.uninstall()

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
                        .closeTo(timeExpectedAfterFinishing, TIME_PRECISION)
                    done()

            louie.start()
            clock.tick(1000)

        it 'should stop the loop after the last task has finished', (done) ->
            louie.addTask
                timeout: 0
                task: ->

            louie.start()

            setTimeout ->
                expect(louie.isRunning()).to.be.false
                done()
            , 100
            clock.tick(100)

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
                        .closeTo(timeExpectedAfterFinishingFirst, TIME_PRECISION)

            louie.addTask
                timeout: secondTimeout
                task: ->
                    expect(Date.now()).to.be
                        .closeTo(timeExpectedAfterFinishingSecond, TIME_PRECISION)

            louie.addTask
                timeout: thirdTimeout
                task: ->
                    expect(Date.now()).to.be
                        .closeTo(timeExpectedAfterFinishingThird, TIME_PRECISION)
                    done()

            tasks = louie.getTasks()
            expect(tasks).to.have.length(3)

            louie.start()
            clock.tick(firstTimeout)
            clock.tick(secondTimeout)
            clock.tick(thirdTimeout)

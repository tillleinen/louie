class Test
	constructor: ->
		@_isRunning = false
		@_tasks = []

	start: ->
		@_isRunning = true

	stop: ->
		@_isRunning = false

	isRunning: ->
		@_isRunning

	getTasks: ->
		@_tasks

	addTask: (task) ->
		@_tasks.push task

module.exports = Test

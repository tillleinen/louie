class Test
	constructor: ->
		@_tasks = []
		@_interval = null

	start: ->
		@_interval = setInterval =>
			@_processNextTask()
		, 1000

	stop: ->
		clearInterval(@_interval)
		@_interval = null

	isRunning: ->
		!!@_interval

	getTasks: ->
		@_tasks

	addTask: (task) ->
		@_tasks.push task

	_processNextTask: ->
		nextTask = @_tasks.pop()
		if typeof nextTask.task == 'function'
			nextTask.task()
		

module.exports = Test

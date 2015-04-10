class Test
	constructor: ->
		@_tasks = []
		@_timeout = null

	start: ->
		@_timeout = setTimeout =>
			@_processNextTask()
			@start()
		, @_getNextTimeout()

	stop: ->
		clearTimeout(@_timeout)
		@_timeout = null

	isRunning: ->
		!!@_timeout

	getTasks: ->
		@_tasks

	addTask: (task) ->
		@_tasks.push task

	_processNextTask: ->
		nextTask = @_tasks.shift()
		if typeof nextTask.task == 'function'
			nextTask.task()

	_getNextTimeout: ->
		nextTask = @_tasks[0]
		timeout = nextTask.timeout if nextTask
		timeout || 1000

module.exports = Test

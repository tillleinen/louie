class Louie
	constructor: ->
		@_tasks = []
		@_timeout = null

	start: ->
		@_timeout = setTimeout =>
			@_processNextTask()
			if @_tasks.length > 0
				@start()
			else
				@stop()
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
		unless typeof timeout == 'undefined'
			return timeout
		1000

module.exports = Louie

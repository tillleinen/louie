# louie

louie is a timeable loop for executing tasks written in JavaScript.

## Installatio

## Getting Started
```JavaScript
var louie = new Louie();

louie.addTask({
    timeout: 10000,
    task: function() {
        console.log('called after 10000ms');
    }
});

louie.addTask({
    timeout: 5000,
    task: function() {
        console.log('called after 15000ms');
    }
});

louie.start();
```

## API

### addTask(task)
Adds a task to the queue. ```task``` is an object with the properties ```task``` and ```timeout``` (optional).
```JavaScript
louie.addTask({
    timeout: 1000,
    task: function() {}
});
```

### getTasks()
Returns an Array of tasks.
```JavaScript
var tasks = louie.getTasks();
```

### isRunning()
Can be used to check if the loop is running.
```JavaScript
louie.isRunning();
```

### start()
Starts the loop.
```JavaScript
louie.start();
louie.isRunning(); // true
```

### stop()
Stops the loop.
```JavaScript
louie.stop();
louie.isRunning(); // false
```

## Development

```bash
npm start # watches and compiles coffeescript
```

### Tests
```bash
npm test
```

## License
Licensed under the MIT license.

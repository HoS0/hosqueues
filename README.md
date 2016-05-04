# hos-queues

HoS services and instances info from RabbitMq management

`npm install hos-queues`

## Example

``` javascript
var hosqueues = require('hos-queues');
hosqueues.now()
.then(function(res){
    console.log(res);
})
.catch(function(err){
    console.log(err);
})
```

you can set:

- AMQP_URL
- AMQP_MANAGMENT_PORT
- AMQP_USERNAME
- AMQP_PASSWORD

as environmental variables or set them programmatically:

``` javascript
var hosqueues = require('hos-queues');
hosqueues.amqpaddress = 'localhost'
hosqueues.amqpManagementPort = '15672'
hosqueues.amqpusername = 'guest'
hosqueues.amqppassword = 'guest'
hosqueues.now()
.then(function(res){
    console.log(res);
})
.catch(function(err){
    console.log(err);
})
```

## Running Tests

Run test by:

`gulp test`

This software is licensed under the MIT License.

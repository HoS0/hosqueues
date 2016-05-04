module.exports = (rp, URLSafeBase64, Promise) ->
    amqpaddress: process.env.AMQP_URL ? "localhost"
    amqpManagementPort: process.env.AMQP_MANAGMENT_PORT ? "15672"
    amqpusername: process.env.AMQP_USERNAME ? "guest"
    amqppassword: process.env.AMQP_PASSWORD ? "guest"

    decodeQueueName: (encodedName)->
        ret = JSON.parse URLSafeBase64.decode encodedName
        ret.CreateOn = new Date(ret.CreateOn).toLocaleString()
        return ret

    createServicesObject: (rabbitmqResponce)->
        rabbitmqResponce.sort (a, b)->
          return a.name.length - b.name.length

        ret = {}
        for queue in rabbitmqResponce
            nameparts = queue.name.split '.'
            if nameparts[1]
                try
                    instance = @decodeQueueName nameparts[1]
                    instance.address = queue.name
                    ret[nameparts[0]].instances.push instance
                catch error
                    # ignore
            else
                ret[queue.name] =
                    instances: []
                    messages: queue.messages
                    messages_details: queue.messages_details
                    messages_ready: queue.messages_ready
                    messages_ready_details: queue.messages_ready_details
                    messages_unacknowledged: queue.messages_unacknowledged
                    messages_unacknowledged_details: queue.messages_unacknowledged

        return ret

    now: ()->
        return new Promise (fullfil, reject)=>
            options =
                method: 'get',
                uri: "http://#{@amqpaddress}:#{@amqpManagementPort}/api/queues"
                json: true
                headers:
                    'Content-Type': 'application/json'
                    'Authorization': 'Basic ' + new Buffer("#{@amqpusername}:#{@amqppassword}", "utf8").toString('base64')

            rp(options)
            .then (rep)=>
                fullfil(@createServicesObject(rep))

            .catch (e)=>
                reject(e.error)

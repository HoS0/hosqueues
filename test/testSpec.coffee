Promise = require('bluebird')
helper  = require('./helper')
URLSafeBase64 = require('urlsafe-base64')
rp = require('request-promise')

hosqueues = require('../src/hosqueues')(helper.rp, URLSafeBase64, Promise)

describe "Ruun hos queues", ()->
    it "and load any verify two swagger json", (done)->
        hosqueues.now()
        .then (res)=>
            expect(Object.keys(res).length).toBe(5)
            service = res[Object.keys(res)[0]]
            expect(service.instances.length).toBe(1)
            expect(Object.keys(res)[0]).toBe('/api')
            service = res[Object.keys(res)[2]]
            expect(service.instances.length).toBe(2)
            expect(typeof service.instances[1]).toBe('object')
            expect(typeof service.instances[1].HostName).toBe('string')
            expect(typeof service.instances[1].ID).toBe('string')
            expect(typeof service.instances[1].address).toBe('string')
            done()

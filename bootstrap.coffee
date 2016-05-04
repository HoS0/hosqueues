rp = require('request-promise')
URLSafeBase64 = require('urlsafe-base64')
Promise = require('bluebird')

swaggermerge = require('./src/hosqueues')(rp, URLSafeBase64, Promise)

module.exports = swaggermerge

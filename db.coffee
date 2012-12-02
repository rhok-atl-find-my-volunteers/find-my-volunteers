cradle = require 'cradle'

exports.connect = ()->
  prod = !!process.env.CLOUDANT_URL
  url = 'http://127.0.0.1'
  url = process.env.CLOUDANT_URL if prod
  port = 5984
  port = 443 if prod

  (new cradle.Connection url, port, {
    cache: true
    raw: false
  }).database 'db'
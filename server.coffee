express = require "express"
fs = require "fs"
app = express()

port = 8080
base = __dirname+'/public'

GLOBAL.app = app

app.configure ->
  app.use express.logger(format: "dev")
  app.use express.compress()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.methodOverride()
  app.use express.static(base)
  app.use app.router
  app.use (req, res) ->
    res.sendfile(__dirname+"/public/index.html")

app.configure "development", ->
app.use express.errorHandler(
  dumpExceptions: true
  showStack: true
)

app.configure "production", ->
  app.use express.errorHandler()

app.listen port
console.log "Mozart Express server listening on port #{port}"
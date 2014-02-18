express = require('express')
service = express()
data = require('./AiRData')

# route
service.get('/', (req, res)->
	res.send('AiR RESTFul Service'))

service.get('/TestCard/:id', data.LoadTestCard)
service.get('/SearchTestCardByModel/:modelNumber', data.SearchTestCardByModel)

# use express middleware
service.use(express.bodyParser())
service.use(express.methodOverride())
service.use(express.static(__dirname + '/public'))

# use authentication
#service.all('*', requireAuthentication)

# error handling
service.use((err, req, res, next)->
	console.error(err.stack)
	res.send(500, 'Something broke!'))

service.listen(8808)
console.log('AiR RESTFul Service is listening on port 8808.')

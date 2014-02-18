module.exports.LoadTestCard = (req, res)->
	cardJson = {id: req.params.id, name: '34970A',\
	            description: 'Test Card for 34970A'}
	res.send(cardJson)

module.exports.SearchTestCardByModel = (req, res)->
	cardJson = {id: '9898', name: 'Test Card',\
            model: '34970A', description: 'Test Card for 34970A'}
	res.send(cardJson)


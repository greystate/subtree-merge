# Provide easy access to QueryString data
class QueryString
	
	constructor: (@queryString) ->
		@queryString or= window.document.location.search?.substr 1
		@variables = @queryString.split '&'
		@pairs = ([key, value] = pair.split '=' for pair in @variables)
	
	get: (name) ->
		for [key, value] in @pairs
			return value if key is name

#### Static method(s)

	@fromKeys: (keys) ->
		qs = ("#{key}=#{value}" for key, value of keys).join "&"
		"?#{qs}"
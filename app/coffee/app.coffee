# @codekit-prepend "querystring.coffee"

# jQuery-like utility-function to get to an element
$ = (id) ->
	document.querySelector id

# Return a `value` wrapped in `<mark>` tags
markWrap = (value) ->
	"<mark>#{value}</mark>"

# Pick up the typed values and interpolate into the commandstring
getCommands = () ->
	remoteFolder = ($ '#remote_folder').value
	localFolder = ($ '#local_folder').value
	githubUser = ($ '#github_user').value
	repoName = ($ '#repo_name').value
	branchName = ($ '#branch_name').value
	
	commands = """
		git remote add -f #{markWrap(repoName)} https://github.com/#{markWrap(githubUser)}/#{markWrap(repoName)}.git
		git merge -s ours --no-commit #{markWrap(repoName)}/#{markWrap(branchName)}
		git read-tree --prefix=#{markWrap(localFolder)} -u #{markWrap(repoName)}/#{markWrap(branchName)}:#{markWrap(remoteFolder)}
		
		git commit -m "Subtree merged in #{markWrap(localFolder)}"
	"""
	# Update the "Terminal" output
	($ '#output').innerHTML = "<samp>#{commands}</samp>"

# Update the Terminal output "all the time" (this is not a heavy-lifting app, so the `keyup` event works even though it's a little brute)
document.body.addEventListener "keyup", getCommands, true

# Finally we'll manually fire the update once the page has loaded
getCommands()
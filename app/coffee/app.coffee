# jQuery-like utility-function to get to an element
$ = (id) ->
	document.querySelector id

# Pick up the typed values and interpolate into the commandstring
getCommands = () ->
	remoteFolder = ($ '#remote_folder').value
	localFolder = ($ '#local_folder').value
	githubUser = ($ '#github_user').value
	repoName = ($ '#repo_name').value
	branchName = ($ '#branch_name').value
	
	commands = """
		git remote add -f <mark>#{repoName}</mark> https://github.com/<mark>#{githubUser}</mark>/<mark>#{repoName}</mark>.git
		git merge -s ours --no-commit <mark>#{repoName}</mark>/<mark>#{branchName}</mark>
		git read-tree --prefix=<mark>#{localFolder}</mark> -u <mark>#{repoName}</mark>/#{branchName}</mark>:<mark>#{remoteFolder}</mark>
		
		git commit -m "Subtree merged in <mark>#{localFolder}</mark>"
	"""
	# Update the "Terminal" output
	($ '#output').innerHTML = "<samp>#{commands}</samp>"

# Update the Terminal output "all the time" (this is not a heavy-lifting app, so the `keyup` event works even though it's a little brute)
document.body.addEventListener "keyup", getCommands, true

# Finally we'll manually fire the update once the page has loaded
getCommands()
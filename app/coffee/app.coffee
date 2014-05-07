$ = (id) ->
	document.querySelector id

window.getCommands = () ->
	remoteFolder = ($ '#remote_folder').value
	localFolder = ($ '#local_folder').value
	githubUser = ($ '#github_user').value
	repoName = ($ '#repo_name').value
	branchName = ($ '#branch_name').value
	
	commands = """
		$ git remote add -f <span style="font-weight:bold">#{repoName}</span> git://github.com/<span style="font-weight:bold">#{githubUser}</span>/<span style="font-weight:bold">#{repoName}</span>.git
		$ git merge -s ours --no-commit <span style="font-weight:bold">#{repoName}</span>/<span style="font-weight:bold">#{branchName}</span>
		$ git read-tree --prefix=<span style="font-weight:bold">#{localFolder}</span> -u <span style="font-weight:bold">#{repoName}</span>/#{branchName}</span>:<span style="font-weight:bold">#{remoteFolder}</span>
		$ git commit -m "Subtree merged in <span style="font-weight:bold">#{localFolder}</span>"
	"""
	
	($ '#output').innerHTML = "<samp>#{commands}</samp>"

document.body.addEventListener "keyup", window.getCommands, true
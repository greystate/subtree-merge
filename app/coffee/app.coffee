# @codekit-prepend "querystring.coffee"

# jQuery-like utility-function to get to an element
$ = (selector) ->
	document.querySelector selector

# Return a `value` wrapped in `<mark>` tags
markWrap = (value) ->
	"<mark>#{value}</mark>"

selectText = (element) ->
	doc = document
	src = $ element

	if doc.body.createTextRange?
		range = doc.body.createTextRange()
		range.moveToElementText src
		range.select()
	else if window.getSelection?
		selection = window.getSelection()
		range = doc.createRange()
		range.selectNodeContents src
		selection.removeAllRanges()
		selection.addRange(range)

setupFromQueryString = () ->
	qs = new QueryString()
	if qs.pairs.length >= 5
		($ '#remote_folder').value = qs.get "rf"
		($ '#local_folder').value  = qs.get "lf"
		($ '#github_user').value   = qs.get "u"
		($ '#repo_name').value     = qs.get "r"
		($ '#branch_name').value   = qs.get "b"

# Pick up the typed values and interpolate into the commandstring
getCommands = () ->
	remoteFolder = ($ '#remote_folder').value
	branchName = ($ '#branch_name').value
	githubUser = ($ '#github_user').value
	repoName = ($ '#repo_name').value
	localFolder = ($ '#local_folder').value
	
	commands = """
		git remote add -f #{markWrap(repoName)} https://github.com/#{markWrap(githubUser)}/#{markWrap(repoName)}.git
		git merge -s ours --no-commit --allow-unrelated-histories #{markWrap(repoName)}/#{markWrap(branchName)}
		git read-tree --prefix=#{markWrap(localFolder)} -u #{markWrap(repoName)}/#{markWrap(branchName)}:#{markWrap(remoteFolder)}
		
		git commit -m "Subtree merged in #{markWrap(localFolder)}"
	"""
	# Update the "Terminal" output
	($ '#output').innerHTML = "<samp>#{commands}</samp>"
	
	# Update the permalink
	keys =
		rf: remoteFolder
		u: githubUser
		b: branchName
		r: repoName
		lf: localFolder
	
	($ '[rel="bookmark"]').setAttribute "href", QueryString.fromKeys keys

# Update the Terminal output "all the time" (this is not a heavy-lifting app, so the `keyup` event works even though it's a little brute)
document.body.addEventListener "keyup", getCommands, true

# Select everything in the *#output* field when clicked/focused
($ '#output').addEventListener "click", (event) ->
	selectText '#output'
, true


# Let's setup the `<form>` from the **QueryString**, if present
setupFromQueryString()

# Finally we'll manually fire the update once the page has loaded
getCommands()
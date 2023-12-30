# git-status-stripper
A simple bash script to cleanup your git status to minimize copy/paste.
 
cp gstrip ~/bin/gstrip 

Regex:
(?mx)↵
^\t # Left padding↵
(?:deleted:\s*|modified:\s*|) # 'deleted:' or 'modified:' tags↵
(.*) # Capture all remaining text↵
$

# Issues

## [Functions](/1bash.d/functions.sh)
- md encounters an error on multiple arguments, add option to not enter any foler after creating directories
- la does not show the destination of symlinks
- if fzf is not going to be installed on machines as default, glog does not need to be there
- whois can be replaced to curl from outside api
- localip does not work on windows machines
- add a cat pipe to csvpreview to display inline
- camerausedby may not be necessary, usecase is not common
- gifify and webmify require ffmpeg, which is not commonly installed on machines

## [Aliases](/1bash.d/aliases.sh)
- non-windows shortcuts can be removed:
    - a
    - ai

## [Prompt](/1bash.d/prompt.sh)
- The user prompt can not fetch user properly on windows machines, this issue has been resolved by adding a check on USER variable length
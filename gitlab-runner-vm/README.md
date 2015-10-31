# VM bootstrap script for gitlab-runner

##Usage:

1. Install fresh ubuntu distribution

2.1. Non-interactive mode (doesn't require any input while executed):

\# `export CI_URL=http://git.example.com/ci CI_TOKEN=12345abcdef TIMEZONE=America/New_York[ OTHER_VAR=VALUE ...]; curl -S https://raw.githubusercontent.com/TetraWeb/docker/master/gitlab-runner-vm/bootstrap.sh | bash`

OR

2.2. Interactive mode (script will ask for all variables to be typed while run)

\# `curl -S https://raw.githubusercontent.com/TetraWeb/docker/master/gitlab-runner-vm/bootstrap.sh | bash`

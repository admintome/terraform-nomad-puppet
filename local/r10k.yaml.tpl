# The location to use for storing cached Git repos
:cachedir: '/var/cache/r10k'

# A list of git repositories to create
:sources:
  # This will clone the git repository and instantiate an environment per
  # branch in /etc/puppetlabs/code/environments
  :my-org:
    remote: 'http://gitlab.admintome.local/stackadmin/control-repo-nomad.git'
    basedir: '/etc/puppetlabs/code/environments'
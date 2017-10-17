# The location to use for storing cached Git repos
:cachedir: '/var/cache/r10k'
:git:
  provider: 'shellgit'
:sources:
  :my-org:
    remote: '{{ env "NOMAD_META_controlrepo" }}'
    #remote: 'http://gitlab.admintome.local/stackadmin/control-repo-nomad.git'
    basedir: '/etc/puppetlabs/code/environments'
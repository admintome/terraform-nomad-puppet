job "puppet" {

  type = "service"

  datacenters = ["dc1"]
  
  update {
    stagger = "30s"
    max_parallel = 1
  }

  group "puppet" {
    count = 1

    task "postgres" {
      driver = "docker"

      config {
	image = "puppet/puppetdb-postgres:latest"
      }

      resources {
	cpu = 300
	memory = 300
      }

      env {
	POSTGRES_PASSWORD = "puppetdb"
	POSTGRES_USER = "puppetdb"
      }
    }
    
    task "puppetdb" {
      driver = "docker"

      config {
	image = "puppet/puppetdb:latest"
      }

      resources {
	cpu = 300
	memory = 300
      }
    }

    task "puppet" {
      driver = "docker"

      config {
	image = "puppet/puppetserver:latest"
	port_map = {
	  puppet = 8140
	}

	volumes = [
	  "/tmp/code:/etc/puppetlabs/code"
	]
      }

      resources {
	cpu = 500
	memory = 2000
	network {
	  mbits = 200
	  port "puppet" {
	    static = "8140"
	  }
	}
      }

      service {
	name = "puppet"
	tags = ["global","puppet"]
	port = "puppet"
	check {
	  name = "alive"
	  type = "tcp"
	  interval = "10s"
	  timeout = "2s"
	}
      }
    }

    task "r10k" {
      driver = "docker"

      template {
	data          = <<EOF
# The location to use for storing cached Git repos
:cachedir: '/var/cache/r10k'
:git:
  provider: 'shellgit'
:sources:
  :my-org:
    remote: 'http://gitlab.admintome.local/stackadmin/control-repo-nomad.git'
    basedir: '/etc/puppetlabs/code/environments'
EOF
	destination   = "local/r10k.yaml"
	change_mode   = "signal"
	change_signal = "SIGINT"
      }

      config {
	image = "billcloudme/r10k:latest"
	volumes = [
	  "/tmp/code:/etc/puppetlabs/code",
	  "local:/tmp/r10k"
	]
	command = "deploy"
	args = [
	  "environment",
	  "-p",
	  "-c","/tmp/r10k/r10k.yaml",
	  "-vv"
	]
      }
      
      resources {
	cpu = 300
	memory = 300
      }
    }
  }
  
}

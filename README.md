# Nomad Puppet Terraform module

This is a Terraform module that will provision a puppet environment on a Nomad cluster

## Usabe

```
module "puppet" {
  source = "admintome/puppet/nomad"
}
```

After you do a ```terraform get``` you will need to update the puppet.hcl file in the module directory.  Update the line for the hiera.yaml template:

```
    remote: 'http://gitlab.admintome.local/stackadmin/control-repo-nomad.git'
```

Update that line to the actual git URL of your control reposiory.  For instructions on creating one see the [r10k documentation](https://github.com/puppetlabs/r10k/blob/master/doc/dynamic-environments/quickstart.mkd).  This is because at the moment Nomad doesn't allow interpolating variables into templates (See nomad issue [#1185](https://github.com/hashicorp/nomad/issues/1185))

## Author

Module managed by [AdminTome](http://www.admintome.com)

Git Repos for [AdminTome](https://github.com/admintome)

## License

Apache 2 Licensed.  See LICENSE for full details

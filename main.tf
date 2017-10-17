resource "nomad_job" "puppet" {
  jobspec = "${file("${path.module}/puppet.hcl")}"
}

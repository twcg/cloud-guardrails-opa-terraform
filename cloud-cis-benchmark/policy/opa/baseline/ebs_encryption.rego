package terraform.ebs_baseline

# CIS Baseline: Require EBS encryption at rest (CIS-aligned concept)

deny contains msg if {
  vol := input.resource_changes[_]
  vol.mode == "managed"
  vol.type == "aws_ebs_volume"

  not vol.change.after.encrypted

  msg := sprintf("CIS Baseline: EBS volume %s must have encrypted=true.", [vol.address])
}

deny contains msg if {
  vol := input.resource_changes[_]
  vol.mode == "managed"
  vol.type == "aws_ebs_volume"

  vol.change.after.encrypted == false

  msg := sprintf("CIS Baseline: EBS volume %s must have encrypted=true.", [vol.address])
}

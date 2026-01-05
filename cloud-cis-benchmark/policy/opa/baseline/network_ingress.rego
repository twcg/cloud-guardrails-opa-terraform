package terraform.network_baseline

# CIS Baseline: Block world-open admin ports (SSH/RDP)

admin_ports := {22, 3389}

deny contains msg if {
  r := input.resource_changes[_]
  r.mode == "managed"
  r.type == "aws_security_group_rule"
  r.change.after.type == "ingress"

  r.change.after.cidr_blocks[_] == "0.0.0.0/0"
  r.change.after.protocol == "tcp"

  from := r.change.after.from_port
  to := r.change.after.to_port

  some p in admin_ports
  p >= from
  p <= to

  msg := sprintf("CIS Baseline: %s allows 0.0.0.0/0 to admin port(s).", [r.address])
}

deny contains msg if {
  r := input.resource_changes[_]
  r.mode == "managed"
  r.type == "aws_vpc_security_group_ingress_rule"

  r.change.after.cidr_ipv4 == "0.0.0.0/0"
  r.change.after.ip_protocol == "tcp"

  from := r.change.after.from_port
  to := r.change.after.to_port

  some p in admin_ports
  p >= from
  p <= to

  msg := sprintf("CIS Baseline: %s allows 0.0.0.0/0 to admin port(s).", [r.address])
}

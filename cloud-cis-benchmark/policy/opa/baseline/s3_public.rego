package terraform.s3_baseline

# CIS Baseline: Block public S3 exposure
# (CIS-aligned concept: S3 Block Public Access + no public ACLs)

deny contains msg if {
  rc := input.resource_changes[_]
  rc.mode == "managed"
  rc.type == "aws_s3_bucket_acl"

  acl := rc.change.after.acl
  acl == "public-read"

  msg := sprintf("CIS Baseline: S3 bucket ACL is public (%s). Public ACLs are not allowed.", [acl])
}

deny contains msg if {
  rc := input.resource_changes[_]
  rc.mode == "managed"
  rc.type == "aws_s3_bucket_acl"

  acl := rc.change.after.acl
  acl == "public-read-write"

  msg := sprintf("CIS Baseline: S3 bucket ACL is public (%s). Public ACLs are not allowed.", [acl])
}

deny contains msg if {
  bucket := input.resource_changes[_]
  bucket.mode == "managed"
  bucket.type == "aws_s3_bucket"

  not any_public_access_block

  msg := sprintf("CIS Baseline: S3 bucket %s is missing aws_s3_bucket_public_access_block.", [bucket.address])
}

any_public_access_block if {
  pab := input.resource_changes[_]
  pab.mode == "managed"
  pab.type == "aws_s3_bucket_public_access_block"
  pab.change.after.block_public_acls == true
  pab.change.after.ignore_public_acls == true
  pab.change.after.block_public_policy == true
  pab.change.after.restrict_public_buckets == true
}

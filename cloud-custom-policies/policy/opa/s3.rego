package terraform.s3

# -------------------------------
# Deny public S3 ACLs
# -------------------------------
deny contains msg if {
  rc := input.resource_changes[_]
  rc.mode == "managed"
  rc.type == "aws_s3_bucket_acl"
  rc.change.after.acl == "public-read"

  msg := "S3 bucket ACL is public (public-read). Public S3 buckets are not allowed."
}

deny contains msg if {
  rc := input.resource_changes[_]
  rc.mode == "managed"
  rc.type == "aws_s3_bucket_acl"
  rc.change.after.acl == "public-read-write"

  msg := "S3 bucket ACL is public (public-read-write). Public S3 buckets are not allowed."
}

# -------------------------------
# Deny missing Public Access Block
# (MVP: require at least one public access block in the plan)
# -------------------------------
deny contains msg if {
  b := input.resource_changes[_]
  b.mode == "managed"
  b.type == "aws_s3_bucket"
  not any_public_access_block

  msg := sprintf("S3 bucket %s is missing aws_s3_bucket_public_access_block.", [b.address])
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

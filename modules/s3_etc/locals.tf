locals {
  # Common locals
  pre-fix = "${var.project_id}-${var.env_id}"
  pre_fix = "${var.project_id}_${var.env_id}"

  s3_logs = "${local.pre-fix}-logs"
}

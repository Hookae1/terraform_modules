locals {
  # Common locals
  pre-fix = "${var.project_id}-${var.env_id}"
  pre_fix = "${var.project_id}_${var.env_id}"

  app_ids             = var.app_ids
  project_id_to_upper = upper(var.project_id)
}

# generic clusters have no pre_create scripts because they already exists at this point.

resource "shell_script" "post_create" {
  for_each = toset(concat(var.post_create, var.generic_post_create))

  lifecycle_commands {
    create = each.value
    read   = "echo {}"
    update = each.value
    delete = "echo {}"
  }

  environment = {}
}

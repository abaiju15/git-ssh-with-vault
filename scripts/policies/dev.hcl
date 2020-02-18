path "ssh/creds/dev/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

path "ssh/sign/dev/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

path "ssh/sign/dev" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

path "sys/mounts" {
   capabilities = ["read"]
}
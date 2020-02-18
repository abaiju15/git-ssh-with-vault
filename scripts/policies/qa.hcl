path "ssh/creds/qa/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

path "ssh/creds/qa" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}


path "sys/mounts" {
   capabilities = ["read"]
}

path "sys/leases/revoke/ssh/creds/qa/*" {
  capabilities = [ "delete", "update" ]
}
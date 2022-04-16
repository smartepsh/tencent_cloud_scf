defmodule SCF.API.Namespace do
  use SCF.API,
    actions: [:update_namespace, :list_namespaces, :delete_namespace, :create_namespace]
end

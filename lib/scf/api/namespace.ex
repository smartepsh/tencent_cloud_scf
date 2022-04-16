defmodule SCF.API.Namespace do
  @moduledoc """
  Some shortcut functions for [Namespace APIs](https://intl.cloud.tencent.com/document/product/583/34410)
  """
  use SCF.API,
    actions: [:update_namespace, :list_namespaces, :delete_namespace, :create_namespace]
end

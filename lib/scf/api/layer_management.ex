defmodule SCF.API.LayerManagement do
  @moduledoc """
  Some shortcut functions for [LayerManagement APIs](https://intl.cloud.tencent.com/document/product/583/36315)
  """
  use SCF.API,
    actions: [
      :publish_layer_version,
      :list_layers,
      :list_layer_versions,
      :get_layer_version,
      :delete_layer_version
    ]
end

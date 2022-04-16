defmodule SCF.API.LayerManagement do
  use SCF.API,
    actions: [
      :publish_layer_version,
      :list_layers,
      :list_layer_versions,
      :get_layer_version,
      :delete_layer_version
    ]
end

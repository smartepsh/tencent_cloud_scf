defmodule SCF.API.LayerManagementTest do
  use ExUnit.Case, async: true

  alias SCF.API.LayerManagement, as: APIModule

  test "exported all expected functions" do
    all_functions = [
      :publish_layer_version,
      :list_layers,
      :list_layer_versions,
      :get_layer_version,
      :delete_layer_version
    ]

    {:module, _} = Code.ensure_loaded(APIModule)

    for function_name <- all_functions do
      assert function_exported?(APIModule, function_name, 0)
      assert function_exported?(APIModule, function_name, 1)
      assert function_exported?(APIModule, function_name, 2)
    end
  end
end

defmodule SCF.API.TriggerTest do
  use ExUnit.Case, async: true

  alias SCF.API.Trigger, as: APIModule

  test "exported all expected functions" do
    all_functions = [:delete_trigger, :create_trigger, :list_triggers]

    {:module, _} = Code.ensure_loaded(APIModule)

    for function_name <- all_functions do
      assert function_exported?(APIModule, function_name, 0)
      assert function_exported?(APIModule, function_name, 1)
      assert function_exported?(APIModule, function_name, 2)
    end
  end
end

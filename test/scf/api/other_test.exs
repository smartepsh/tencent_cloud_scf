defmodule SCF.API.OtherTest do
  use ExUnit.Case, async: true

  alias SCF.API.Other, as: APIModule

  test "exported all expected functions" do
    all_functions = [:get_account]

    {:module, _} = Code.ensure_loaded(APIModule)

    for function_name <- all_functions do
      assert function_exported?(APIModule, function_name, 0)
      assert function_exported?(APIModule, function_name, 1)
      assert function_exported?(APIModule, function_name, 2)
    end
  end
end

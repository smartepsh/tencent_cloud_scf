defmodule SCF.API.FunctionTest do
  use ExUnit.Case, async: true

  alias SCF.API.Function, as: APIModule

  test "exported all expected functions" do
    all_functions = [
      :invoke,
      :update_function_configuration,
      :update_function_code,
      :list_functions,
      :get_function_logs,
      :get_function,
      :delete_function,
      :create_function,
      :copy_function,
      :publish_version,
      :list_version_by_function,
      :get_function_address,
      :delete_alias,
      :update_alias,
      :list_aliases,
      :get_alias,
      :create_alias,
      :put_total_concurrency_config,
      :put_reserved_concurrency_config,
      :put_provisioned_concurrency_config,
      :get_reserved_concurrency_config,
      :get_provisioned_concurrency_config,
      :delete_reserved_concurrency_config,
      :delete_provisioned_concurrency_config,
      :update_function_event_invoke_config,
      :get_function_event_invoke_config,
      :invoke_function,
      :get_request_status
    ]

    {:module, _} = Code.ensure_loaded(APIModule)

    for function_name <- all_functions do
      assert function_exported?(APIModule, function_name, 0)
      assert function_exported?(APIModule, function_name, 1)
      assert function_exported?(APIModule, function_name, 2)
    end
  end
end

defmodule SCF.API.Function do
  @moduledoc """
  Some shortcut functions for [Function APIs](https://intl.cloud.tencent.com/document/product/583/17242)
  """
  use SCF.API,
    actions: [
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
end

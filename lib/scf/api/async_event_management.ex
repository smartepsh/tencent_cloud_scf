defmodule SCF.API.AsyncEventManagement do
  @moduledoc """
  Some shortcut functions for [AsyncEventManagement APIs](https://intl.cloud.tencent.com/document/product/583/39732)
  """
  use SCF.API, actions: [:terminate_async_event, :list_async_events, :get_async_event_status]
end

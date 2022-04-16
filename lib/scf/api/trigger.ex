defmodule SCF.API.Trigger do
  @moduledoc """
  Some shortcut functions for [Trigger APIs](https://intl.cloud.tencent.com/document/product/583/18587)
  """
  use SCF.API, actions: [:delete_trigger, :create_trigger, :list_triggers]
end

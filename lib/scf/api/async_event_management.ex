defmodule SCF.API.AsyncEventManagement do
  use SCF.API, actions: [:terminate_async_event, :list_async_events, :get_async_event_status]
end

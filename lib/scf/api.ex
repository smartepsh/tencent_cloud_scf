defmodule SCF.API do
  defmacro __using__(opts) do
    for action <- opts[:actions] do
      quote do
        def unquote(action)() do
          %{"Action" => SCF.Utils.atom_to_action(unquote(action))}
          |> SCF.HTTP.auth_post()
        end

        def unquote(action)(params) do
          params
          |> Map.put("Action", SCF.Utils.atom_to_action(unquote(action)))
          |> SCF.HTTP.auth_post()
        end

        def unquote(action)(params, opts) do
          params
          |> Map.put("Action", SCF.Utils.atom_to_action(unquote(action)))
          |> SCF.HTTP.auth_post(opts)
        end
      end
    end
  end
end

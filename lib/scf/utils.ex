defmodule SCF.Utils do
  def atom_to_action(action) when is_atom(action) do
    action |> Atom.to_string() |> Macro.camelize()
  end

  # TODO: remove when we require OTP 22.1
  if Code.ensure_loaded?(:crypto) and function_exported?(:crypto, :mac, 4) do
    def hmac(sub_type, key, data), do: :crypto.mac(:hmac, sub_type, key, data)
  else
    def hmac(sub_type, key, data), do: :crypto.hmac(sub_type, key, data)
  end
end

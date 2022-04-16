defmodule SCF.Utils do
  def atom_to_action(action) when is_atom(action) do
    action |> Atom.to_string() |> Macro.camelize()
  end
end

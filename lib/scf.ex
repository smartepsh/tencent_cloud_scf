defmodule SCF do
  def config do
    :tencent_cloud_scf
    |> Application.get_all_env()
    |> Map.new()
    |> merge_default_config()
  end

  defp merge_default_config(config) do
    default_config = %{
      api_host: "scf.tencentcloudapi.com",
      api_version: "2018-04-16",
      http_client: [adapter: Tesla.Adapter.Hackney],
      language: "zh-CN"
    }

    Map.merge(default_config, config)
  end
end

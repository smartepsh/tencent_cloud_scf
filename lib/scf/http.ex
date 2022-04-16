defmodule SCF.HTTP do
  alias SCF.Auth

  @common_params [
    "Action",
    "Region",
    "Timestamp",
    "Version",
    "Token",
    "Language"
  ]

  @spec auth_post(params :: map) :: {:ok, map} | {:error, map}
  @spec auth_post(params :: map, opts :: keyword) :: {:ok, map} | {:error, map}
  def auth_post(params, opts \\ []) do
    {common_params, body} = Map.split(params, @common_params)
    headers = Enum.map(common_params, fn {key, value} -> {"X-TC-#{key}", value} end)
    request(body, headers, opts)
  end

  @spec request(body :: map, headers :: [tuple], opts :: keyword) :: {:ok, map} | {:error, map}
  def request(body, headers, opts) do
    config = SCF.config()

    host = config[:api_host]
    url = "https://" <> host
    encoded_body = Jason.encode!(body)

    headers =
      headers
      |> put_new_header({"Host", host})
      |> put_new_header({"Content-Type", "application/json"})
      |> put_new_header({"X-TC-Version", config[:api_version]})
      |> put_new_header({"X-TC-Timestamp", DateTime.utc_now() |> DateTime.to_unix()})
      |> put_new_header({"X-TC-Region", config[:region]})
      |> put_new_header({"X-TC-Language", config[:language]})
      |> Enum.reject(fn {_key, value} -> is_nil(value) end)

    authorization = Auth.authorization(encoded_body, headers, config)

    options = [
      method: :post,
      url: url,
      headers: [{"Authorization", authorization} | headers],
      body: encoded_body,
      opts: opts
    ]

    [Tesla.Middleware.JSON]
    |> Tesla.client(config.http_client[:adapter])
    |> Tesla.request(options)
    |> case do
      {:ok, %{body: %{"Response" => %{"Error" => _} = response}}} ->
        {:error, response}

      {:ok, %{status: 200, body: %{"Response" => response}}} ->
        {:ok, response}

      {:ok, %{body: body}} ->
        {:error, body}
    end
  end

  @doc false
  def put_new_header(headers, {key, value}) do
    key_exists? =
      Enum.find(headers, fn
        {_key, nil} -> false
        {^key, _value} -> true
        _ -> false
      end)

    if key_exists? do
      headers
    else
      [{key, value} | headers]
    end
  end

  @doc false
  def common_params do
    @common_params
  end
end

# SCF - Tencent Cloud SCF Elixir SDK

- Tencent Cloud SCF API Document: [en-us](https://intl.cloud.tencent.com/document/product/583/17241) or [zh-cn](https://cloud.tencent.com/document/product/583/17234)

- Use [signature v3](https://intl.cloud.tencent.com/document/product/583/31703) and `POST` only.

## Installation

The package can be installed by adding `tencent_cloud_scf` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tencent_cloud_scf, "~> 0.1.0"}
  ]
end
```

## Configuration

```elixir
config :tencent_cloud_scf,
  secret_id: "secret_id",
  secret_key: "secret_key",
  region: "your-region",
  # Optional
  http_client: [adapter: Tesla.Hackney],
  language: "your-language",
  api_host: "your-api_host"
```

## Request API

Take this api [ListFunctions](https://intl.cloud.tencent.com/document/product/583/18582) as an example. There are 3 ways to request it.

### 1. shortcut functions

There are 3 shortcut functions:

- `SCF.API.Function.list_functions/0` - with default common parameters.

- `SCF.API.Function.list_functions/1` - with default common parameters and body parameters.

- `SCF.API.Function.list_functions/2` - with default common parameters & body parameters & http client options.

> If the api has required parameters other than the common parameters, the shortcut function with `/0` is invalid.

### 2. `SCF.HTTP.auth_post(parameters, opts \\ [])`

Build the parameters by referring the document. `opts` is http client options.

```elixir
# don't add "X-TC-" prefix to common parameters
params = %{"Action" => "ListFunctions"}

SCF.HTTP.auth_post(params)
```

### 3. `SCF.HTTP.request(parameters, headers, opts)` (not recommended)

Build parameters and headers manually.

```elixir
headers = [{"X-TC-Action", "ListFunctions"}]

SCF.HTTP.request(%{}, headers, [])
```

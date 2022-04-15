import Config

config :tencent_cloud_scf,
  secret_id: "secret_id",
  secret_key: "secret_key",
  http_client: [adapter: Tesla.Mock]

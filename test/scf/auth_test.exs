defmodule SCF.AuthTest do
  use ExUnit.Case, async: true

  alias SCF.Auth

  test "a correct example" do
    encoded_body = "{\"some_key\":\"some_values\"}"
    datetime = ~U[2022-04-16 00:00:00.0000Z] |> DateTime.to_unix()

    headers = [
      {"X-TC-Timestamp", datetime},
      {"Host", "test-host"},
      {"Content-Type", "application/json"}
    ]

    config = SCF.config()

    assert Auth.authorization(encoded_body, headers, config) ==
             "TC3-HMAC-SHA256 Credential=secret_id/2022-04-16/scf/tc3_request, SignedHeaders=content-type;host;x-tc-timestamp, Signature=d9209f7456a5d9074407c9771a0601cb1a142ed0689f973be3ba03298a73d44e"
  end
end

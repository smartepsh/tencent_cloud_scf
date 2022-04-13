defmodule SCF.Auth do
  @moduledoc """
  TC3-HMAC-SHA256 Signature Algorithm

  [Signature V3](https://cloud.tencent.com/document/product/583/33846) with POST only.
  """

  @requested_service "scf"
  @termination_string "tc3_request"

  @spec authorization(encoded_body :: binary, headers :: [tuple], config :: map) :: binary
  def authorization(encoded_body, headers, config) do
    http_request_method = "POST"
    canonical_uri = "/"
    canonical_query_string = ""
    algorithm = "TC3-HMAC-SHA256"
    secret_id = Map.fetch!(config, :secret_id)
    secret_key = Map.fetch!(config, :secret_key)

    # 1. Concatenating the CanonicalRequest String
    formatted_headers = downcase_and_sort(headers)

    canonical_headers =
      formatted_headers
      |> Enum.map(fn {key, value} -> "#{key}:#{value}\n" end)

    signed_headers = formatted_headers |> Enum.map(fn {key, _value} -> key end) |> Enum.join(";")

    hashed_request_payload = encoded_body |> hash_sha256() |> Base.encode16(case: :lower)

    canonical_request =
      Enum.join(
        [
          http_request_method,
          canonical_uri,
          canonical_query_string,
          canonical_headers,
          signed_headers,
          hashed_request_payload
        ],
        "\n"
      )

    # 2. Concatenating the String to Be Signed
    {_key, request_timestamp} =
      Enum.find(formatted_headers, fn
        {"x-tc-timestamp", _value} -> true
        _ -> false
      end)

    credential_date =
      request_timestamp |> DateTime.from_unix!() |> DateTime.to_date() |> Date.to_iso8601()

    credential_scope = "#{credential_date}/#{@requested_service}/#{@termination_string}"
    hashed_canonical_request = canonical_request |> hash_sha256() |> Base.encode16(case: :lower)

    string_to_sign =
      Enum.join([algorithm, request_timestamp, credential_scope, hashed_canonical_request], "\n")

    # 3. Calculating the Signature
    signature =
      ("TC3" <> secret_key)
      |> hmac_sha256(credential_date)
      |> hmac_sha256(@requested_service)
      |> hmac_sha256(@termination_string)
      |> hmac_sha256(string_to_sign)
      |> Base.encode16(case: :lower)

    # 4. Concatenating the Authorization
    "#{algorithm} Credential=#{secret_id}/#{credential_scope}, SignedHeaders=#{signed_headers}, Signature=#{signature}"
  end

  defp downcase_and_sort(headers) do
    headers
    |> Enum.map(fn
      {key, value} when is_binary(value) ->
        {String.downcase(key), value |> String.downcase() |> String.trim()}

      {key, value} ->
        {String.downcase(key), value}
    end)
    |> Enum.sort_by(fn {key, _value} -> key end)
  end

  defp hash_sha256(data), do: :crypto.hash(:sha256, data)
  defp hmac_sha256(key, data), do: :crypto.mac(:hmac, :sha256, key, data)
end

defmodule SCF.HTTPTest do
  use ExUnit.Case, async: true

  import Tesla.Mock

  alias SCF.HTTP

  describe "auth_post/1" do
    test "split common params to headers and body params, & add X-TC- prefix to headers" do
      mock(fn %{method: :post, headers: headers, body: body} ->
        assert Enum.any?(headers, &(elem(&1, 0) == "X-TC-Action"))
        assert %{"BodyParams" => "params"} = Jason.decode!(body)

        json(%{"Response" => %{"RequestID" => "id"}}, stauts: 200)
      end)

      HTTP.auth_post(%{"Action" => "action", "BodyParams" => "params"})
    end

    test "common_params" do
      assert HTTP.common_params() == [
               "Action",
               "Region",
               "Timestamp",
               "Version",
               "Token",
               "Language"
             ]
    end
  end

  describe "request/3" do
    test "returns {:ok, response} without error" do
      mock(fn %{method: :post} -> json(%{"Response" => %{"RequestID" => "id"}}, stauts: 200) end)
      assert {:ok, %{"RequestID" => "id"}} = HTTP.request(%{}, [{"Action", "API"}], [])
    end

    test "returns {:error, response} with status 200" do
      mock(fn %{method: :post} -> json(%{"Response" => %{"Error" => "reason"}}, stauts: 200) end)

      assert {:error, %{"Error" => "reason"}} = HTTP.request(%{}, [{"Action", "API"}], [])
    end

    test "returns {:error, body} for other situations" do
      mock(fn %{method: :post} -> json(%{"other" => "reason"}, stauts: 400) end)

      assert {:error, %{"other" => "reason"}} = HTTP.request(%{}, [{"Action", "API"}], [])
    end

    test "success request with auth header & reject nil headers" do
      mock(fn %{method: :post, url: _, headers: headers} ->
        assert Enum.any?(headers, &(elem(&1, 0) == "Authorization"))
        refute Enum.any?(headers, &(elem(&1, 0) == "Key"))

        json(%{"Response" => %{}}, stauts: 200)
      end)

      assert {:ok, %{}} = HTTP.request(%{}, [{"Action", "API"}, {"Key", nil}], [])
    end
  end

  describe "put_new_header/2" do
    test "put new header success" do
      assert [{"key", "value"}] = HTTP.put_new_header([], {"key", "value"})
    end

    test "put new header if the exist key header value is nil" do
      assert [{"key", "new_value"}, {"key", nil}] =
               HTTP.put_new_header([{"key", nil}], {"key", "new_value"})
    end

    test "doesn't put header if header exists (key)" do
      assert [{"key", "value"}] = HTTP.put_new_header([{"key", "value"}], {"key", "new_value"})
    end
  end
end

defmodule Vacdec do
  @moduledoc """
  Documentation for `Vacdec`.
  """

  def parse(<<"HC1:", cert::binary>> = string) when is_binary(string) do
    with {:base45_decoding, {:ok, base45_decoded}} <- {:base45_decoding, base45_decode(cert)},
         {:zlib_inflate, {:ok, zlib_inflated}} <- {:zlib_inflate, zlib_inflate(base45_decoded)},
         {:cose_decode, {:ok, cose_decoded}} <- {:cose_decode, cbor_decode(zlib_inflated)},
         {:cose_decode, {:ok, cose_value}} <- {:cose_decode, Map.fetch(cose_decoded, :value)},
         {:cose_payload_access, {:ok, cose_payload}} <-
           {:cose_payload_access, Enum.fetch(cose_value, 2)},
         {:certificate_decode, {:ok, cose_payload_value}} <-
           {:certificate_decode, Map.fetch(cose_payload, :value)},
         {:certificate_decode, {:ok, covid_certificate}} <-
           {:certificate_decode, cbor_decode(cose_payload_value)} do
      {:ok, covid_certificate}
    else
      {failed_step, _} -> {:error, failed_step}
    end
  end

  def parse(string) when is_binary(string) do
    {:error, "Invalid header"}
  end

  defp base45_decode(string) when is_binary(string) do
    {:ok, :base45.decode(string)}
  end

  defp zlib_inflate(binary) when is_binary(binary) do
    with z <- :zlib.open(),
         :ok <- :zlib.inflateInit(z),
         [bytes] <- :zlib.inflate(z, binary),
         :ok = :zlib.close(z) do
      {:ok, bytes}
    else
      _ -> {:error, :zlib_error}
    end
  end

  defp cbor_decode(binary) when is_binary(binary) do
    try do
      with {:ok, decoded, _rest} <- CBOR.decode(binary) do
        {:ok, decoded}
      else
        _ -> {:error, :cbor_error}
      end
    catch
      _ -> {:error, :cbor_error}
    end
  end
end

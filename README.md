# vacdec

A simple elixir library to parse the EU Covid-19 vaccine certificate, as [specified by the EU](https://ec.europa.eu/health/ehealth/covid-19_en).
Based on (https://github.com/hannob/vacdec).

**It will not validate the signature.**

The code is very short and should provide an easy way to understand
how these certificates are encoded:

* The QR code encodes a string starting with "HC1:".
* The string following "HC1:" is base45 encoded.
* Decoding the base45 leads to zlib-compressed data.
* Decompression leads to a CBOR Web Token structure.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `vacdec` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:vacdec, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/vacdec](https://hexdocs.pm/vacdec).


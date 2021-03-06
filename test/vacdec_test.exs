defmodule VacdecTest do
  use ExUnit.Case
  doctest Vacdec

  @sample_text "HC1:6BFOXN*TS0BI$ZD4N9:9S6RCVN5+O30K3/XIV0W23NTDEPWK G2EP4J0B3KLASMUG8GJL8LLG.3SA3/-2E%5VR5VVBJZILDBZ8D%JTQOL2009UVD0HX2JN*4CY009TX/9F/GZ%5U1MC82*%95HC2FCG2K80H-1GW$5IKKQJO0OPN484SI4UUIMI.J9WVHWVH+ZE/T9MX1HRIWQHCR2HL9EIAESHOP6OH6MN9*QHAO96Y2/*13A5-8E6V59I9BZK6:IR/S09T./0LWTHC0/P6HRTO$9KZ56DE/.QC$QUC0:GOODPUHLO$GAHLW 70SO:GOV636*2. KOKGKZGJMI:TU+MMPZ5OV1 V125VE-4RZ4E%5MK9BM57KPGX7K:7D-M1MO0Q2AQE:CA7ED6LF90I3DA+:E3OGJMSGX8+KL1FD*Y49+574MYKOE1MJ-69KKRB4AC8.C8HKK9NTYV4E1MZ3K1:HF.5E1MRB4WKP/HLIJL8JF8JF172M*8OEB2%7OREF:FO:7-WF11SKCU1MH8FWPVH%L635OBXTY*LPM6B9OBYSH:4Q1BQ:A5+I6:DQR9VKR8 BLHCFQMZA5:PHR14%GV4ZOP50$ A 3"

  @sample_term %{
    1 => "DE",
    4 => 1_651_928_945,
    6 => 1_620_392_945,
    -260 => %{
      1 => %{
        "v" => [
          %{
            "ci" => "01DE/00000/1119349007/BW1DDJEZX2B0VGVYII1QN7DDU#S",
            "co" => "DE",
            "dn" => 2,
            "dt" => "2021-05-07",
            "is" => "Bundesministerium für Gesundheit",
            "ma" => "ORG-100030215",
            "mp" => "EU/1/20/1528",
            "sd" => 2,
            "tg" => "840539006",
            "vp" => "1119349007"
          }
        ],
        "dob" => "1970-01-01",
        "nam" => %{
          "fn" => "Dießner Musterfrau",
          "gn" => "Erika Dörte",
          "fnt" => "DIESSNER<MUSTERFRAU",
          "gnt" => "ERIKA<DOERTE"
        },
        "ver" => "1.0.0"
      }
    }
  }

  @invalid_header "XX1:6BFOXN*TS0BI$ZD4N9:9S6RCVN5+O30K3/XIV0W23NTDEPWK G2EP4J0B3KLASMUG8GJL8LLG.3SA3/-2E%5VR5VVBJZILDBZ8D%JTQOL2009UVD0HX2JN*4CY009TX/9F/GZ%5U1MC82*%95HC2FCG2K80H-1GW$5IKKQJO0OPN484SI4UUIMI.J9WVHWVH+ZE/T9MX1HRIWQHCR2HL9EIAESHOP6OH6MN9*QHAO96Y2/*13A5-8E6V59I9BZK6:IR/S09T./0LWTHC0/P6HRTO$9KZ56DE/.QC$QUC0:GOODPUHLO$GAHLW 70SO:GOV636*2. KOKGKZGJMI:TU+MMPZ5OV1 V125VE-4RZ4E%5MK9BM57KPGX7K:7D-M1MO0Q2AQE:CA7ED6LF90I3DA+:E3OGJMSGX8+KL1FD*Y49+574MYKOE1MJ-69KKRB4AC8.C8HKK9NTYV4E1MZ3K1:HF.5E1MRB4WKP/HLIJL8JF8JF172M*8OEB2%7OREF:FO:7-WF11SKCU1MH8FWPVH%L635OBXTY*LPM6B9OBYSH:4Q1BQ:A5+I6:DQR9VKR8 BLHCFQMZA5:PHR14%GV4ZOP50$ A 3"

  test "valid certificate" do
    # Verify the content from https://github.com/Digitaler-Impfnachweis/certification-apis/tree/master/examples

    assert {:ok, @sample_term} = Vacdec.parse(@sample_text)
  end

  test "invalid header" do
    assert {:error, _} = Vacdec.parse(@invalid_header)
  end
end

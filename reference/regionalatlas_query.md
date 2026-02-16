# Query Regionalatlas data

Query Regionalatlas data

## Usage

``` r
regionalatlas_query(
  table,
  where = "1=1",
  out_fields = "*",
  return_geometry = FALSE,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- table:

  Table name containing indicators (e.g., "ai002_1_5" for population
  density). See Details for common tables.

- where:

  Optional SQL WHERE clause for filtering.

- out_fields:

  Fields to return (default "\*" for all).

- return_geometry:

  Logical; include geometry in response.

- params:

  Additional query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with regional indicator data.

## Details

The Regionalatlas API provides access to over 160 regional indicators
from the German statistical offices. Data is available at various
administrative levels (Bundeslaender, Regierungsbezirke, Kreise,
Gemeinden). Official docs:
https://github.com/bundesAPI/regionalatlas-api.

Common tables and their indicators:

- `ai002_1_5`: Population (ai0201=density, ai0202=change,
  ai0208=foreigners %)

- `ai002_4_5`: Age (ai0218=average age, ai0219=mother age at 1st child)

- `ai008_1_5`: Employment (ai0801=unemployment rate)

- `ai_s_01`: Disposable income per capita

- `ai_s_04`: SGB-II quota

- `ai017_1`: GDP per employee

- `ai005`: Federal election results

Regional levels in data: typ 1=Bundeslaender, 2=Regierungsbezirke,
3=Kreise, 5=Gemeinden. Filter using WHERE clause, e.g.,
`where = "typ = 1"`.

## See also

[`bunddev_parameters()`](https://mchlbckr.github.io/bunddev/reference/bunddev_parameters.md)
for available query parameters.

## Examples

``` r
if (FALSE) { # \dontrun{
# Population density indicators
regionalatlas_query("ai002_1_5")

# Filter for Bundeslaender only
regionalatlas_query("ai002_1_5", where = "typ = 1")

# Age data for Kreise
regionalatlas_query("ai002_4_5", where = "typ = 3")
} # }
```

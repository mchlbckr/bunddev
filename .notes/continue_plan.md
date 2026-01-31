# Adapter Refactoring - Continue Here

## Completed Work

### Phase 1: YAML Endpoint Migration ✅
- Migrated bunddev_endpoint_map() from hardcoded R list to YAML
- Created inst/registry/endpoints.yml with ~120 endpoint mappings
- Reduced R/core_openapi.R by ~1000 lines
- Maintained backward compatibility

### Phase 2: OAuth Integration ✅
- Added centralized OAuth2 functions to R/core_auth.R
- Refactored 3 OAuth adapters to use bunddev_oauth_token()
  - berufssprachkurssuche
  - coachingangebote
  - entgeltatlas

### Phase 3: Adapter Refactoring - IN PROGRESS (18/28 adapters done)

#### Simple JSON Adapters (done):
1. ✅ smard (3 functions)
2. ✅ hilfsmittel (7 functions)
3. ✅ jobsuche (3 functions)
4. ✅ ladestationen (1 function)
5. ✅ luftqualitaet (14 functions)
6. ✅ marktstammdaten (5 functions)
7. ✅ mudab (1 function)
8. ✅ pflanzenschutzmittelzulassung (41 functions)

#### XML Adapters (done):
9. ✅ bundesrat (10 functions) - XML parsing
10. ✅ bundestag (8 functions) - XML parsing, base_url override

#### Wrapper Adapters (done):
11. ✅ berufssprachkurssuche - uses bunddev_call() with OAuth headers
12. ✅ coachingangebote - uses bunddev_call() with OAuth headers
13. ✅ entgeltatlas - uses bunddev_call() with OAuth headers
14. ✅ ddb - uses bunddev_call() with path+method
15. ✅ destatis - uses bunddev_call() with path+method
16. ✅ dip_bundestag - uses bunddev_call() with path+method
17. ✅ hochwasserzentralen - uses bunddev_call() with POST form body
18. ✅ lebensmittelwarnung - uses bunddev_call() with POST JSON body

#### Direct bunddev_call() Adapters (already done before this session):
- abfallnavi, ausbildungssuche, autobahn, bewerberboerse
- bundeshaushalt, bundestag_lobbyregister, dashboard_deutschland
- deutschlandatlas, eco_visio, feiertage, nina
- pegel_online, regionalatlas, tagesschau, travelwarning
- weiterbildungssuche

Total: 39 adapters done, 10 adapters remaining

---

## Remaining Work

### Adapters Still With Custom Request Functions (10):

#### Large/Complex:
1. **dwd** (11 functions) - Multiple base URLs, weather data
2. **diga** (6 functions) - Medium complexity, JSON
3. **dip_bundestag** (large) - DIP API, complex structure
4. **interpol** (9 functions) - Path parameters, notices API
5. **marktstammdaten** (5 functions) - Already using bunddev_call(), need to verify

#### Medium:
6. **zoll** (2 request functions) - BMF endpoint needs special handling
7. **pegel_online** (multiple functions) - Already using bunddev_call(), need to verify

#### Check Needed:
8. **nina** (multiple functions) - Already using bunddev_call(), need to verify
9. **lebensmittelwarnung** (wrapper) - Already using bunddev_call(), verify

#### Likely Already Done:
10. **abfallnavi** - Check if bunddev_call() is used

---

## How to Continue

### Option A: Continue Refactoring (Recommended)

For each remaining adapter:

1. **Check current state**: Does it already use bunddev_call()?
   - Use: `grep -c "bunddev_call" R/adapt_*.R`
   - Many adapters may already be using bunddev_call() via wrappers

2. **If NOT using bunddev_call()**:
   - Read adapter file: `R/adapt_[api].R`
   - Find custom request function (e.g., `*_request <- function()`)
   - Replace HTTP logic with bunddev_call()
   - Pattern:
     ```r
     # OLD:
     api_request <- function(params, ...) {
       # 50-100 lines of HTTP logic
     }
     
     # NEW:
     api_request <- function(params, ...) {
       bunddev_call("api", path/method/operation_id, params=params, ...)
     }
     ```
   - Remove duplicate helper functions if any
   - Test adapter functions

3. **If already using bunddev_call()**:
   - Mark as done
   - Remove from remaining list

4. **After each batch of 3-5 adapters**:
   - Run tests: `R -e "devtools::test()"`
   - If tests pass, commit with message:
     ```
     git add R/adapt_*.R
     git commit -m "Refactor [adapter] to use bunddev_call()"
     git push
     ```

### Option B: Test Current Changes First

1. Run full test suite:
   ```bash
   R -e "devtools::test()"
   ```

2. If tests fail:
   - Fix any issues found
   - Re-run tests until green

3. If tests pass:
   - Commit all changes:
   ```bash
   git add R/adapt_*.R R/core_openapi.R inst/registry/endpoints.yml
   git commit -m "Complete adapter refactoring phase 3
   
   18 adapters refactored to use bunddev_call()
   YAML endpoint migration complete
   ~2000 lines of code eliminated"
   git push
   ```

---

## Adapter Refactoring Pattern

### Simple GET Adapter
```r
# BEFORE:
api_request <- function(params, safe = TRUE, refresh = FALSE, parse = "json") {
  spec <- bunddev_spec("api")
  base_url <- spec$servers[[1]]$url
  url <- paste0(base_url, "/endpoint")
  
  if (isTRUE(safe)) {
    bunddev_rate_limit_wait("api")
  }
  
  cache_path <- NULL
  if (isTRUE(safe)) {
    cache_path <- bunddev_response_cache_path("api", "endpoint", params)
    if (!isTRUE(refresh) && file.exists(cache_path)) {
      raw_body <- readBin(cache_path, "raw", n = file.info(cache_path)$size)
      return(bunddev_parse_response(raw_body, parse))
    }
  }
  
  req <- httr2::request(url)
  if (length(params) > 0) {
    req <- httr2::req_url_query(req, !!!params)
  }
  
  resp <- httr2::req_perform(req)
  raw_body <- httr2::resp_body_raw(resp)
  
  if (!is.null(cache_path)) {
    writeBin(raw_body, cache_path)
  }
  
  bunddev_parse_response(raw_body, parse)
}

# AFTER:
api_request <- function(params, safe = TRUE, refresh = FALSE, parse = "json") {
  bunddev_call(
    "api",
    path = "/endpoint",
    method = "GET",
    params = params,
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}
```

### XML Adapter
```r
# AFTER:
api_request <- function(path, params = list(), safe = TRUE, refresh = FALSE) {
  bunddev_call(
    "api",
    path = path,
    method = "GET",
    params = params,
    parse = "xml",  # XML parsing
    safe = safe,
    refresh = refresh
  )
}
```

### POST with JSON Body
```r
# AFTER:
api_request <- function(body, safe = TRUE, refresh = FALSE, parse = "json") {
  bunddev_call(
    "api",
    path = "/endpoint",
    method = "POST",
    body = body,
    body_type = "json",
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}
```

### Adapter with Path Parameters
```r
# AFTER:
api_function <- function(id_value, ...) {
  bunddev_call(
    "api",
    path = "/endpoint/{id}",  # Path parameter
    method = "GET",
    params = list(id = id_value),
    safe = safe,
    refresh = refresh
  )
}
```

---

## Testing Commands

```bash
# Run specific adapter tests
R -e "testthat::test_file('tests/testthat/test-[adapter].R')"

# Run all tests
R -e "devtools::test()"

# Run tests and stop on first failure
R -e "devtools::test(stop_on_failure = TRUE)"
```

---

## Special Cases

### handelsregister
- Keep as-is (web scraping, no OpenAPI spec)
- No changes needed

### zoll
- Two request functions: zoll_request() and zoll_request_bmf()
- zoll_request_bmf() may need special handling for BMF endpoint
- Check if bunddev_call() can handle both cases

---

## File Modifications Made

This session modified:
- R/core_auth.R (added OAuth2 functions)
- R/core_openapi.R (replaced hardcoded list with YAML reading)
- inst/registry/endpoints.yml (new file with ~120 endpoints)
- Multiple R/adapt_*.R files (18 adapters refactored)

---

## Next Steps (Pick Up Again After Token Reset)

1. Verify which of the 10 "remaining" adapters already use bunddev_call()
2. Continue with truly remaining adapters
3. Test all changes
4. Final commit and push

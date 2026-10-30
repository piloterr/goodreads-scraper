<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Goodreads Scraper API by Piloterr – scrape Goodreads data as JSON" width="100%"></a>
</p>

# Goodreads Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Goodreads Scraper API** lets you extract public data from Goodreads as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Goodreads Book API** — Read one Goodreads book by the numeric id from search, such as 44767458 for Dune.
- **Goodreads Search API** — Search Goodreads books by keyword.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Goodreads Book API](#goodreads-book-api) | `/v2/goodreads/book` | 2 | Read one Goodreads book by the numeric id from search, such as 44767458 for Dune. |
| [Goodreads Search API](#goodreads-search-api) | `/v2/goodreads/search` | 2 | Search Goodreads books by keyword. pagination.next is a Goodreads search URL for the following page. |

## Table of contents

- [How it works](#how-it-works)
- [Goodreads Book API](#goodreads-book-api)
- [Goodreads Search API](#goodreads-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Goodreads Book API

Read one Goodreads book by the numeric id from search, such as 44767458 for Dune.

`GET | POST https://api.piloterr.com/v2/goodreads/book` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. The numeric Goodreads book id from search, or a /book/show/ URL. A title is not accepted. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/goodreads/book",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "44767458",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type GoodreadsBook = {
  id?: string;
  url?: string;
  isbn?: string;
  image?: string;
  pages?: number;
  title?: string;
  awards?: string[];
  genres?: string[];
  rating?: number;
  series?: string;
  authors?: string[];
  language?: string;
  published?: string;
  book_format?: string;
  description?: string;
  ratings_count?: number;
  reviews_count?: number;
};

const params = new URLSearchParams({
  "query": "44767458",
});

const response = await fetch(`https://api.piloterr.com/v2/goodreads/book?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as GoodreadsBook;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/goodreads/book
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "44767458"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "44767458",
  "url": "https://www.goodreads.com/book/show/44767458",
  "isbn": "9780593099322",
  "image": "https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1555447414i/44767458.jpg",
  "pages": 658,
  "title": "Dune",
  "awards": [
    "Hugo Award Best Novel (1966)",
    "Nebula Award Best Novel (1965)"
  ],
  "genres": [
    "Science Fiction",
    "Fiction"
  ],
  "rating": 4.29,
  "series": "Dune #1",
  "authors": [
    "example"
  ],
  "language": "English",
  "published": "June 1, 1965",
  "book_format": "Hardcover",
  "description": "Set on the desert planet Arrakis, Dune is the story of the boy Paul Atreides, heir to a noble family tasked with ruling an inhospitable w…",
  "ratings_count": 1723657,
  "reviews_count": 90495
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `url` | string |  |
| `isbn` | string |  |
| `image` | string |  |
| `pages` | integer |  |
| `title` | string |  |
| `awards` | string[] |  |
| `genres` | string[] |  |
| `rating` | number |  |
| `series` | string |  |
| `authors` | string[] |  |
| `language` | string |  |
| `published` | string |  |
| `book_format` | string |  |
| `description` | string |  |
| `ratings_count` | integer |  |
| `reviews_count` | integer |  |

## Goodreads Search API

Search Goodreads books by keyword. pagination.next is a Goodreads search URL for the following page.

`GET | POST https://api.piloterr.com/v2/goodreads/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. A book keyword, or a Goodreads search URL (the path contains /search or the query contains q=). |
| `page` | number | — | Optional. Page number, starting at 1. Omitted or blank uses page 1. A value below 1 returns 400. When query is already a Goodreads search URL, this number replaces the page parameter in that URL. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/goodreads/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "dune",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type GoodreadsSearch = {
  results?: {
    id?: string;
    url?: string;
    image?: string;
    title?: string;
    rating?: number;
    series?: string;
    authors?: string[];
    ratings_count?: number;
    reviews_count?: number;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: unknown;
  };
};

const params = new URLSearchParams({
  "query": "dune",
});

const response = await fetch(`https://api.piloterr.com/v2/goodreads/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as GoodreadsSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/goodreads/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "dune"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": "44767458",
      "url": "https://www.goodreads.com/book/show/44767458",
      "image": "https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1555447414i/44767458.jpg",
      "title": "Dune",
      "rating": 4.29,
      "series": "Dune (Series #1)",
      "authors": [
        "example"
      ],
      "ratings_count": 1700000,
      "reviews_count": 90400
    }
  ],
  "pagination": {
    "next": "https://www.goodreads.com/search?q=dune&page=2",
    "page": 1,
    "per_page": 20,
    "total_pages": 100,
    "total_results": null
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].url` | string |  |
| `results[].image` | string |  |
| `results[].title` | string |  |
| `results[].rating` | number |  |
| `results[].series` | string |  |
| `results[].authors` | string[] |  |
| `results[].ratings_count` | integer |  |
| `results[].reviews_count` | integer |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | object |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Book | Search |
|---|---|---|
| cURL (Bash) | [`book`](examples/curl/book.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`book`](examples/php/book.php) | [`search`](examples/php/search.php) |
| C# | [`book`](examples/csharp/Book.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`book`](examples/go/book.go) | [`search`](examples/go/search.go) |
| Java | [`book`](examples/java/BookExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`book`](examples/ruby/book.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`book`](examples/nodejs/book.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Goodreads plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Goodreads?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/goodreads/book` **2**, `/v2/goodreads/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Goodreads API return?

Each endpoint returns structured JSON: **Goodreads Book** — `id`, `url`, `isbn`, `image`, `pages`, `title`; **Goodreads Search** — `results[]`, `results[].id`, `results[].url`, `results[].image`, `results[].title`, `results[].rating`.

### How do I paginate Goodreads results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Goodreads is a trademark of its respective owner. This repository is not affiliated with or endorsed by Goodreads. Examples are released under the MIT license.</sub>

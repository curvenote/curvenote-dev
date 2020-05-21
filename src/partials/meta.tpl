{# favicon, etc. #}
  <meta charset="utf-8" />
  <link rel="icon" href="/favicon.ico" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="{{ site.theme }}" />

  <meta name="description" content="{{ page.description }}" />
{# Schema.org markup #}
  <meta itemprop="name" content="{{ page.title }}">
  <meta itemprop="description" content="{{ page.description }}">
  <meta itemprop="image" content="{{ site.url }}{{ page.thumbnail }}">
{# Twitter Card data #}
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:site" content="@{{ site.twitter }}">
  <meta name="twitter:title" content="{{ page.title }}">
  <meta name="twitter:description" content="{{ page.description }}">
  <meta name="twitter:creator" content="{{ page.twitter }}">
  <meta name="twitter:image:src" content="{{ site.url }}{{ page.thumbnail }}">
{# Open Graph data #}
  <meta property="og:title" content="{{ page.title }}" />
  <meta property="og:type" content="article" />
  <meta property="og:url" content="{{ site.url }}{{ page.url }}" />
  <meta property="og:image" content="{{ site.url }}{{ page.thumbnail }}" />
  <meta property="og:description" content="{{ page.description }}" />
  <meta property="og:site_name" content="{{ site.name }}" />
{# Article publish time #}
  <meta property="article:published_time" content="{{ site.dateISO }}" />
  <meta property="article:modified_time" content="{{ site.dateISO }}" />

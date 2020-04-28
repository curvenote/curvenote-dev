<!doctype html>
<html lang="en"{{ ' itemscope itemtype="http://schema.org/Article"' | safe if page.isHtmlArticle }}>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, minimum-scale=1, initial-scale=1, user-scalable=yes">
  <title>{{ page.title }} | {{ site.name }}</title>
{% block head %}{% endblock %}
{% block meta %}{% endblock %}
{% block scripts %}{% endblock %}
{% include 'partials/google_analytics.tpl' %}
</head>
<body>
{% block body %}{% endblock %}
</body>
</html>

{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Callout</h1>
<r-demo>
  <aside class="callout">A default callout!</aside>
  <aside class="callout active">A <code>active</code> callout!</aside>
  <aside class="callout success">A <code>success</code> callout!</aside>
  <aside class="callout info">A <code>info</code> callout!</aside>
  <aside class="callout warning">A <code>warning</code> callout!</aside>
  <aside class="callout danger">A <code>danger</code> callout!</aside>
</r-demo>
{% endblock%}

{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Showcase</h1>
<div>
{% for item in showcase %}
  <r-card title="{{ item.title }}" description="{{ item.description }}" img-src="{{ item.thumbnail }}" url="{{ item.url }}" contain></r-card>
{% endfor %}
</div>

<aside class="callout">
  <p>
    Do you have an example you would like to add?!
    Send us a link to some of your work at <a href="mailto:hello@iooxa.dev">hello@iooxa.dev</a>
    or add an example through <a href="https://github.com/iooxa/article" target="_blank">GitHub</a>.
  </p>
</aside>

{% endblock %}

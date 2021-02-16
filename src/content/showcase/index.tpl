{% extends "layout/article.tpl" %}
{% block article %}
<h1>Showcase</h1>

<aside class="callout">
  <p>
    Do you have an example you would like to add?!
    Send us a link to some of your work at <a href="mailto:{{ site.email }}">{{ site.email }}</a>
    or add an example through <a href="https://github.com/curvenote/article" target="_blank">GitHub</a>.
  </p>
</aside>

<div class="card-container">
{% for item in showcase %}
  <r-card title="{{ item.title }}" description="{{ item.description }}" img-src="{{ item.thumbnail }}" url="{{ item.url }}" contain></r-card>
{% endfor %}
</div>

{% endblock %}

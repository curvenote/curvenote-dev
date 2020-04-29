{% extends "layout/base.tpl" %}
{% block scripts %}
{% include 'partials/css.tpl' %}
{% include 'partials/fonts.tpl' %}
  <script async src="/js/iooxa.min.js"></script>
{% endblock %}
{% block meta%}
{% include 'partials/meta.tpl' %}
{% endblock %}
{% block body %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
<article{{ ' class="centered"' | safe if page.centered }}>
{% include 'partials/logo.tpl' %}
{% block article %}{% endblock %}
<hr>
{% include 'partials/bottom_links.tpl' %}
</article>
{% block postArticle %}
{% endblock %}
{% endblock %}

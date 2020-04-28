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
{% block preArticle %}{% endblock %}
<article{{ ' class="centered"' | safe if page.centered }}>
{% block article %}{% endblock %}
</article>
{% block postArticle %}{% endblock %}
{% endblock %}

{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Aside</h1>
<r-demo>
  <p>This is inline text.</p>
  <aside>And this is in the margin!</aside>
</r-demo>
{% endblock%}

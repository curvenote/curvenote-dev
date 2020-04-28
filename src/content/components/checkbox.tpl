{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Checkbox</h1>
{% include 'partials/spec.tpl' %}

<r-demo>
  <r-var name="v" value="false"></r-var>
  <r-checkbox bind="v" :label="v ? '✅ Thank you!' : '🆘 Check the box!!'"></r-checkbox>
</r-demo>
{% endblock%}

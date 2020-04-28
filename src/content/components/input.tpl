{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Input</h1>
{% include 'partials/spec.tpl' %}

<r-demo>
  <r-var name="x" value="" type="String"></r-var>
  <p>
    The string is: "<r-display bind="x"></r-display>"
  </p>
  <r-input bind="x" label="Question?!"></r-input>
</r-demo>
{% endblock%}

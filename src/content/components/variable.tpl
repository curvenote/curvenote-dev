{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Variable</h1>
{% include 'partials/spec.tpl' %}

<style>
  r-var {
    display: block;
  }
</style>
<r-demo>
  <r-scope name="example">
    <!-- Some variables! -->
    <r-var name="a" value="0"></r-var>
    <r-var name="b" value="true" type="Boolean"></r-var>
    <r-var name="c" value="true" type="String"></r-var>
    <r-var name="d" value="[1,2]" type="Array"></r-var>
    <r-var name="e" value='{"a": 1}' type="Object"></r-var>
  </r-scope>
</r-demo>
{% endblock%}

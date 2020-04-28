{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Display</h1>
{% include 'partials/spec.tpl' %}
<r-demo>
  <r-var name="x" value="0"></r-var>
  <p>
    Remember that <code>r-display</code> is
    <strong><r-display :value="Array(Math.min(Math.round(x), 5)).fill('r').join('')"></r-display></strong>reactive!!.<br>
    The value of x is: <r-display bind="x"></r-display><br>
    Try setting the value of x with the range input: <r-range bind="x" max="5"></r-range>
  </p>
</r-demo>
{% endblock%}

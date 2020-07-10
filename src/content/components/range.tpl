{% extends "layout/article.tpl" %}
{% block article %}
<h1>Range</h1>
{% include 'partials/spec.tpl' %}
<r-demo>
  <r-var name="a"></r-var>
  <p>
    <r-range bind="a"></r-range> <r-display bind="a"></r-display>
  </p>
</r-demo>
<p>The following demo shows the min of one slider hooked up to the max of another!</p>
<r-demo>
  <r-var name="x" value="10"></r-var>
  <r-var name="y" value="150"></r-var>
  <p>
    <r-range bind="x" :max="y"></r-range> <r-display bind="x"></r-display> <br>
  </p>
  <p>
    <r-range bind="y" :min="x" max="200"></r-range> <r-display bind="y"></r-display>
  </p>
</r-demo>
{% endblock%}

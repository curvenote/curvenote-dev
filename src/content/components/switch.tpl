{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Switch</h1>
{% include 'partials/spec.tpl' %}
<r-demo>
  <h3>Pick two:</h3>
  <r-var name="good" value="false" type="Boolean"></r-var>
  <r-var name="cheap" value="false" type="Boolean"></r-var>
  <r-var name="fast" value="false" type="Boolean"></r-var>
  <p><r-switch label="Good" :value="good" :change="value && cheap && fast && Math.random() > 0.5 ? {good: value, cheap: false} : value && cheap && fast ? {good: value, fast: false} : {good: value}"></r-switch></p>
  <p><r-switch label="Cheap" :value="cheap" :change="value && good && fast && Math.random() > 0.5 ? {cheap: value, good: false} : value && good && fast ? {cheap: value, fast: false} : {cheap: value}"></r-switch></p>
  <p><r-switch label="Fast" :value="fast" :change="value && good && cheap && Math.random() > 0.5 ? {fast: value, good: false} : value && good && cheap ? {fast: value, cheap: false} : {fast: value}"></r-switch></p>
</r-demo>
{% endblock%}

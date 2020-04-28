{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Button</h1>
{% include 'partials/spec.tpl' %}

<r-demo>
  <r-var name="a" value="0"></r-var>
  <p>
    <r-button :click="{a: a + 1}" :label="'Click Me! ' + Array(a % 10).fill('🎉').join()"></r-button>
  </p>
</r-demo>

<h3>Attributes</h3>
<r-demo>
  <p><r-button label="Normal"></r-button></p>
  <p><r-button label="Raised" raised></r-button></p>
  <p><r-button label="Outlined" outlined></r-button></p>
  <p><r-button label="Unelevated" unelevated></r-button></p>
  <p><r-button label="Dense" dense></r-button></p>
  <p><r-button label="Disabled" disabled="true"></r-button></p>
</r-demo>
{% endblock%}

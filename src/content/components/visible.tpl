{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Visible</h1>
{% include 'partials/spec.tpl' %}

<r-demo>
  <r-var name="v" value="false"></r-var>
  <r-checkbox bind="v" label="Show answer"></r-checkbox>
  <p>The answer is: <r-visible :visible="v">42, obviously!</r-visible></p>

  <p>Or in equations: </p>
  <r-equation>x = <r-visible :visible="v">42</r-visible></r-equation>
</r-demo>
{% endblock%}

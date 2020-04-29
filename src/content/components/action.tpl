{% extends "layout/article.tpl" %}
{% block article %}
<h1>Action</h1>
{% include 'partials/spec.tpl' %}

<r-demo>
  <r-var name="a" value="0"></r-var>
  <p>
    You can <r-action :click="{a: a + 1}">click me!</r-action><r-display :value="Array(a).fill('🎉').join()"></r-display>
  </p>
  <p>
    Or hover <r-action :hover="{a: 0}">to reset.
  </p>
</r-demo>
{% endblock%}

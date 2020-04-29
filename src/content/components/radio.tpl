{% extends "layout/article.tpl" %}
{% block article %}
<h1>Radio</h1>
{% include 'partials/spec.tpl' %}

<h3>Pick the Radio</h3>
<r-demo>
  <r-var name="v" value="0"></r-var>
  <r-radio :value="v" :change="{v:value}" values="1,2,3" :labels="v==1 ? '📻🎙🎧🎶🔉,☢️,🔘' : '📻,☢️,🔘'"></r-radio>
</r-demo>
{% endblock%}

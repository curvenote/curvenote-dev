{% extends "layout/article.tpl" %}
{% block article %}
<h1>Select</h1>
{% include 'partials/spec.tpl' %}

<r-demo>
  <h3>Select is correct: <r-display :value="a == -1 ? '' : Array(a).fill('🎉').join('')"></r-display></h3>
  <r-var name="a" value="-1"></r-var>
  <r-select :value="a" :change="{a:Number(value)}" values="-1,0,10" labels="Pick,Choice,Select 👈"></r-select>
</r-demo>
{% endblock%}

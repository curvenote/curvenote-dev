{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Dynamic</h1>
{% include 'partials/spec.tpl' %}
<r-var name="x" value="2"></r-var>
<r-demo>
  <p>
    Set the value of x inline: <r-dynamic bind="x" max="5"></r-dynamic>
  </p>
</r-demo>
<p>
  You can also <code>:transform</code> the value of a variable before you format it.
  For example, you might want to say that the admission to a park is <code>'free'</code> when the
  <r-action :click="{x:0}">value == 0</r-action>.
</p>
<r-demo>
  <p>
    The park admission is
    <r-dynamic :value="x" :change="{x: value}" :transform="(value > 0)? value : 'free 🎉'" format="$.2f" max="5"></r-dynamic>.
  </p>
</r-demo>
<r-demo>
  <p>
    You can also use this <code>:transform</code> to say that the park admission is
    <r-dynamic bind="x" :transform="['free','real cheap','cheap','costly','expensive','real expensive'][value]" max="5"></r-dynamic>.<br>
    Or an emoji array <r-dynamic bind="x" :transform="['😍','😄','😊','😐','😒','😔'][value]" max="5"></r-dynamic>
  </p>
</r-demo>
{% endblock%}

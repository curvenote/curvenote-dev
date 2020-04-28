{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Demo</h1>
<p>
  The <code>r-demo</code> component allows you to write html, and then show the <code>innerHTML</code> as code below it.
  The demo component builds on the <a href="/article/code">code component</a> and defaults to having the <code>copy</code>
  turned on.
</p>
<r-demo>
  <r-demo>
    <p>This is a demo of a <code>r-demo</code></p>
  </r-demo>
</r-demo>
{% endblock%}

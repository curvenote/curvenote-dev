{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Quote</h1>
<r-demo>
  <blockquote>
    <p>I would have written a shorter letter, but I did not have the time.</p>
    <footer>
      <cite>Blaise Pascal</cite>
      <time datetime="1656-12-04">December 4, 1656</time>
    </footer>
  </blockquote>
</r-demo>
{% endblock%}

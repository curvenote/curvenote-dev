{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Outline</h1>
<p>
  Creates an outline for the article. You can also use the class <code>"popout"</code> to have it be in the margin.
</p>
<r-demo>
<h2>Hello</h2>
<r-outline open></r-outline>
</r-demo>
<p style="margin-bottom: 100vh;">Space! ⏬</p>
<h2>World</h2>
{% endblock%}

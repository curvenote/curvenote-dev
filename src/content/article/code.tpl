{% extends "layout/article.tpl" %}
{% block article %}
<h1>Code</h1>
<p>
  The code element will highlight your code using <a href="https://highlightjs.org/" target="_blank">highlight.js</a>.
  It will also trim the left margin, and any top/bottom lines out of the presented code.
</p>
<r-demo>
<r-code>
  function square(x){
    return x ** 2;
  }
</r-code>
</r-demo>
{% endblock%}

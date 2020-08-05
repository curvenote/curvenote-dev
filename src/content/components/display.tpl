{% extends "layout/article.tpl" %}
{% block article %}
<h1>Display</h1>
{% include 'partials/spec.tpl' %}
<h2>Basic Display</h2>
<p>
  Displays can be used to show the value of a variable, or simple calculations of that variable.
</p>
<r-demo>
  <r-var name="x" value="0"></r-var>
  <p>
    x is: <r-display :value="x"></r-display><br>
    x squared is: <r-display :value="x ** 2"></r-display><br>
    Change x: <r-range bind="x" max="5"></r-range>
  </p>
</r-demo>
<h2>Non-number Displays</h2>
<p>
  Displays can also be used to generate text based on variable inputs.
  For example, the below demo show adding some <strong>r</strong>'s infront of "reactive".
</p>
<r-demo>
  <p>
    Remember that <code>r-display</code> is
    <strong><r-display :value="Array(Math.min(Math.round(x), 5)).fill('r').join('')"></r-display></strong>reactive!!.<br>
    Change x: <r-range bind="x" max="5"></r-range>
  </p>
</r-demo>
<h2>Transform & Format</h2>
<p>
  You can transform the value of the variable before it is displayed.
  For example, to show <code>"free"</code> when the value of x is zero.
  Note that the <code>format</code> is only applied if the value is a number.
</p>
<r-demo>
  <p>
    The price is <r-display :value="x" :transform="value == 0 ? 'free' : value" format="$.2f"></r-display>,
    which makes me feel: <r-display :value="x" :transform="['😍','😄','😊','😐','😒','😔'][x]"></r-display><br>
    Change x: <r-range bind="x" max="5"></r-range>
  </p>
</r-demo>
<h2>Equations</h2>
<p>
  Displays can also be used in conjunction with other components, like equations.
  This allows for nice formating of numbers, or other reactive transformations.
</p>
<r-demo>
  <p>
    <r-equation>
      x^2 = <r-display :value="x ** 2" format="d"></r-display>
    </r-equation>
    Change x: <r-range bind="x" max="5"></r-range>
  </p>
</r-demo>
{% endblock%}

{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Equation</h1>
<r-outline class="popout"></r-outline>
<p>
    First things first, how might you show a quadratic formula?!?
</p>

<r-demo>
  <r-equation>
    x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}
  </r-equation>
</r-demo>

<p>
  The <code>r-equation</code> wraps <a href="https://khan.github.io/KaTeX/" target="_blank">Katex</a> in a web component.
  You can inspect the component and try writing a new equation to the <code>math</code> property!
</p>

<h2>Updating the Math</h2>

<p>
  To dynamically update the equation there are two ways: (1) you can as usual set the <code>:math</code> property; or (2) you can use the equation in conjunction with <code>r-display</code> and <code>r-visible</code>.
  In the example below we are expanding a Taylor Series which uses the <code>:math</code> property to index into an array when you drag a range.
</p>
<aside>
  <p>
    See the <a href="/showcase/taylor-series">Taylor series example.</a>
  </p>
</aside>

<r-scope name="taylor">
  <r-demo>
    <r-var name="index" value="1"></r-var>
    <r-var name="MrTaylor" value='["f(x) \\approx f(a)", "\\frac {f^{\\prime}(a)}{1!} (x-a)", "\\frac{f^{\\prime\\prime}(a)}{2!} (x-a)^2", "\\frac{f^{(3)}(a)}{3!}(x-a)^3"]' type="Array"></r-var>
    <p>
      Drag me to expand the Taylor Series:
      <r-range bind="index" min="1" max="4"></r-range>
    </p>
    <r-equation :math="MrTaylor.slice(0, index).join(' + ') + ' + \\cdots'"></r-equation>
  </r-demo>
</r-scope>

<aside class="callout warning">
  <p>
    <strong>Note:</strong> You often have to <emph>double escape</emph> back-slashes for them to render properly.
  </p>
</aside>

<h2>Use visible and display</h2>

<r-scope name="ymxb">
  <p>
    In the example below, we will take some care to make sure that we show the right equation.
    For example, try seeing what happens in the equation when
    <r-action :click="{m:0, b:1}">m = 0</r-action> or
    <r-action :click="{m:1, b:1}">m = 1</r-action> or
    <r-action :click="{m:1, b:0}">b = 0</r-action> or
    <r-action :click="{m:0, b:0}">everything is zero</r-action>.
  </p>
  <r-var name="m" value="1"></r-var>
  <r-var name="b" value="1"></r-var>
  <aside>
    <r-svg-chart width="250" height="250" x-axis-location="origin" y-axis-location="origin" xlim="[-10,10]" ylim="[-10,10]">
      <r-svg-eqn eqn="m*x + b" :listen="[m, b]"></r-svg-eqn>
      <r-svg-eqn eqn="m/10*x**2 + b" :listen="[m, b]"></r-svg-eqn>
      <r-svg-node x="0" :y="b" :drag="{b: y}"></r-svg-node>
      <r-svg-node x="5" :y="m*5 + b" :drag="{m: (y - b) / 5}"></r-svg-node>
      <r-svg-node x="-5" :y="m/10*25 + b" :drag="{m: (y - b) / 25 * 10}"></r-svg-node>
    </r-svg-chart>
  </aside>
  <p>
    $m$ = <r-range bind="m" min="-10" max="10"></r-range><r-display bind="m"></r-display>
  </p>
  <p>
    $b$ = <r-range bind="b" min="-10" max="10"></r-range><r-display bind="b"></r-display>
  </p>
  <r-demo>
    <r-equation aligned>
      y &= m \times x + b \\
      y &=
      <r-display :value="m==-1 || m == 0 || m == 1? '' : m" format=".0f"></r-display>
      <r-visible :visible="m == -1">-</r-visible>
      <r-visible :visible="m !== 0">x</r-visible>
      <r-display :value="b==0? '' : b" :format="m==0 ? '.0f' : '+.0f'">+1</r-display>
      <r-visible :visible="m == 0 && b ==0">0</r-visible>
    </r-equation>
  </r-demo>
</r-scope>

<p>
    Here we are just directly writing <code>&lt;r-display&gt;</code> directly inside of the equation tags.
    This works by ensuring that the formatted output of a display is included in the inner-html <emph>outside</emph> of the shadow DOM.
    The equation looks at the <code>textContent</code> of the element for what to render to Katex.
    You can use either approach, <code>:math</code> or inner <code>r-display</code>'s, however, it is <emph>much</emph> easier to format text.
</p>
{% endblock%}

{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
<h1>ArcTan2</h1>
<r-var name="a" value="-3"></r-var>
<r-var name="b" value="3"></r-var>
<r-var name="r" :value="Math.sqrt(a*a + b*b)"></r-var>

<aside>
  <r-svg-chart xlim="[-5, 5]" ylim="[-5, 5]" height="300" width="300" x-axis-location="origin" y-axis-location="origin">
    <r-svg-eqn :domain="[0, Math.atan2(b, a)]" eqn="[r * Math.cos(t), r * Math.sin(t)]" parameterize="t" stroke="#333" stroke-width="1" stroke-dasharray="3"></r-svg-eqn>
    <r-svg-path :data="[[0, 0],[r * Math.cos(Math.atan2(b, a)), r * Math.sin(Math.atan2(b, a))]]" stroke="#333" stroke-width="1" stroke-dasharray="3"></r-svg-path>
    <r-svg-text :x="(r/2) * Math.cos(Math.atan2(b, a) / 2)" :y="(r/2) * Math.sin(Math.atan2(b, a) / 2)" :text="Math.round(Math.atan2(b, a)*180/Math.PI) + '&deg;'"></r-svg-text>
    <r-svg-node :x="a" :y="b" :drag="{a: x, b: y}" r="10"></r-svg-node>
  </r-svg-chart>
</aside>

<p>
  The function $\operatorname{atan2}(y,x)$ (from "2-argument arctangent") is defined as the angle in the Euclidean plane, given in radians, between the positive x-axis and the ray to the point $(x,y)$.

  $\operatorname{atan2}(y,x)$ returns a single value $\theta$ such that $-\pi < \theta \le \pi$ and, for some $r > 0$,

  <r-equation aligned="true">
    x&=r\cos \theta \\
    y&=r\sin \theta
  </r-equation>
</p>

<r-equation aligned="true">
  r &= \sqrt{x^2 + y^2} = <r-display bind="r"></r-display> \\
  \theta &= \operatorname{atan2}(y,x) = <r-display :value="Math.atan2(b, a) * 180 / Math.PI"></r-display>
</r-equation>

<aside>
  <p>
    <strong>$\theta$: </strong><r-dynamic :value="Math.atan2(b, a) * 180 / Math.PI" :change="{
        a: r * Math.cos(value * Math.PI / 180),
        b: r * Math.sin(value * Math.PI / 180)
    }" min="-180" :max="180" step="1" sensitivity="1" periodic="true" after="º"></r-dynamic><br>
    <strong>$r$: </strong><r-dynamic :value="Math.sqrt(a*a + b*b)" :change="{
        a: value * Math.cos(Math.atan2(b, a)),
        b: value * Math.sin(Math.atan2(b, a))
    }" min="0.1" :max="5" step="0.05" sensitivity="5"></r-dynamic><br>
    <strong>$x$: </strong><r-dynamic bind="a" min="-5" :max="5" step="0.05" sensitivity="5"></r-dynamic><br>
    <strong>$y$: </strong><r-dynamic bind="b" min="-5" :max="5" step="0.05" sensitivity="5"></r-dynamic><br>
  </p>
</aside>

<r-svg-chart xlim="[-10, 10]" ylim="[-180, 180]" xlabel="y / x" ylabel="atan2(y,x)" x-axis-location="origin" y-axis-location="origin">
    <r-svg-eqn eqn="Math.atan2(x, 1) * 180/Math.PI"></r-svg-eqn>
    <r-svg-eqn eqn="Math.atan2(-x, -1) * 180/Math.PI" :domain="[-Infinity, -0.05]"></r-svg-eqn>
    <r-svg-eqn eqn="Math.atan2(-x, -1) * 180/Math.PI" :domain="[0.05, Infinity]"></r-svg-eqn>
    <r-svg-eqn eqn="90" stroke="#333" stroke-width="1" stroke-dasharray="1 5"></r-svg-eqn>
    <r-svg-eqn eqn="-90" stroke="#333" stroke-width="1" stroke-dasharray="1 5"></r-svg-eqn>
    <r-svg-text x="4" y="-125" text="x < 0"></r-svg-text>
    <r-svg-text x="4" y="55" text="x > 0"></r-svg-text>
    <r-svg-text x="-4" y="120" text="x < 0"></r-svg-text>
    <r-svg-circle :x="b / a" :y="Math.atan2(b, a) * 180/Math.PI" :r="r*5"></r-svg-circle>
</r-svg-chart>

{% endblock%}

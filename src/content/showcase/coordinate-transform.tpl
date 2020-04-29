{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock%}
{% block article %}
<r-var name="a" value="1"></r-var>
<r-var name="b" value="1"></r-var>
<r-var name="cartesian" value="true" type="Boolean"></r-var>
<r-var name="showX" value="true" type="Boolean"></r-var>
<r-var name="radius" value="true" type="Boolean"></r-var>
<r-var name="r" :value="Math.sqrt(a*a + b*b)"></r-var>
<r-var name="theta" :value="Math.atan2(b, a) * 180 / Math.PI"></r-var>

<h3>Coordinate Transformation</h3>
<p>
  How do you <r-action :click="{cartesian: !cartesian}">change</r-action> from a <r-action :click="{cartesian: false}">radial</r-action> coordinate system to <r-action :click="{cartesian: true}">Cartesian</r-action> coordinate system?!
</p>
<r-svg-chart xlim="[-5, 5]" ylim="[-5, 5]" height="300" width="300" x-axis-location="origin"
  y-axis-location="origin">
  <r-svg-path :visible="cartesian" :data="[[a,0], [a, b]]" :hover="{showX: true}" :stroke="showX ? 'red' : '#333'" strokeWidth="1.5"></r-svg-path>
  <r-svg-path :visible="cartesian" :data="[[a, b], [0,b]]" :hover="{showX: false}" :stroke="!showX ? 'red' : '#333'" strokeWidth="1.5"></r-svg-path>
  <r-svg-path :visible="!cartesian" :data="[[0,0], [a, b]]" :hover="{radius: true}" :stroke="radius ? 'red' : '#333'" strokeWidth="1.5"></r-svg-path>
  <r-svg-eqn :visible="!cartesian && theta != 0" eqn="[Math.cos(t)*r, Math.sin(t)*r]" :domain="[0, theta * Math.PI / 180]" parameterize="t" :hover="{radius: false}"  :stroke="!radius ? 'red' : '#333'" stroke="#333" strokeWidth="1.5"></r-svg-eqn>
  <r-svg-node :x="a" :y="b" :drag="{a: x, b: y, cartesian: x > 0}"></r-svg-node>
</r-svg-chart>
<h4>Cartesian Coordinate System</h4>
<dl>
  <dt>$x$</dt>
  <dd>
    <r-dynamic :value="a" :change="{a: value, cartesian: true, showX: true}" min="-5" :max="5" step="0.05"></r-dynamic>
  </dd>
  <dt>$y$</dt>
  <dd>
    <r-dynamic :value="b" :change="{b: value, cartesian: true, showX: false}" min="-5" :max="5" step="0.05"></r-dynamic>
  </dd>
</dl>
<h4>Radial Coordinate System</h4>
<dl>
  <dt>$r$</dt>
  <dd>
    <r-dynamic :value="Math.sqrt(a*a + b*b)" :change="{
        a: value * Math.cos(Math.atan2(b, a)),
        b: value * Math.sin(Math.atan2(b, a)),
        cartesian: false, radius: true,
    }" min="0.1" :max="5" step="0.05"></r-dynamic>
  </dd>
  <dt>$\theta$</dt>
  <dd>
    <r-dynamic :value="Math.atan2(b, a) * 180 / Math.PI" :change="{
        a: Math.sqrt(a*a + b*b) * Math.cos(value * Math.PI / 180),
        b: Math.sqrt(a*a + b*b) * Math.sin(value * Math.PI / 180),
        cartesian: false, radius: false,
    }" min="-180" :max="180" step="1" periodic="true">&deg;</r-dynamic>
  </dd>
</dl>
<r-visible :visible="cartesian && showX">
  <h4>Cartesian Update- $x$</h4>
  <r-equation>
    x = <r-display bind="a"></r-display>
  </r-equation>
  <r-code language="html">
    &lt;r-dynamic :value="x" :change="{x: value}"&gt;&lt;/r-dynamic&gt;
  </r-code>
</r-visible>
<r-visible :visible="cartesian && !showX">
  <h4>Cartesian Update - $y$</h4>
  <r-equation>
    y = <r-display bind="b"></r-display>
  </r-equation>
  <r-code language="html">
    &lt;r-dynamic :value="y" :change="{y: value}"&gt;&lt;/r-dynamic&gt;
  </r-code>
</r-visible>
<r-visible :visible="!cartesian && radius">
  <h4>Radius Update - $r$</h4>
  <r-equation aligned>
    r &= \sqrt{x^2 + y^2} = <r-display bind="r"></r-display> \\
    x &= r \cos(\operatorname{atan2}(y, x)) = <r-display bind="a"></r-display> \\
    y &= r \sin(\operatorname{atan2}(y, x)) = <r-display bind="b"></r-display>
  </r-equation>
  <r-code language="html">
    &lt;r-dynamic :value="Math.sqrt(x*x + y*y)" :change="{
      x: value * Math.cos(Math.atan2(y, x)),
      y: value * Math.sin(Math.atan2(y, x))
    }"&gt;&lt;/r-dynamic&gt;
  </r-code>
</r-visible>
<r-visible :visible="!cartesian && !radius">
  <h4>Theta Update - $\theta$</h4>
  <r-equation aligned>
    \theta &= \operatorname{atan2}(y, x) = <r-display bind="theta"></r-display> \\
    x &= \sqrt{x^2 + y^2} \cos( \theta ) = <r-display bind="a"></r-display> \\
    y &= \sqrt{x^2 + y^2} \sin( \theta ) = <r-display bind="b"></r-display>
  </r-equation>
  <r-code language="html">
    &lt;r-dynamic :value="Math.atan2(y, x)" :change="{
      x: Math.sqrt(x*x + y*y) * Math.cos(value),
      y: Math.sqrt(x*x + y*y) * Math.sin(value)
    }"&gt;&lt;/r-dynamic&gt;
  </r-code>
</r-visible>
{% endblock%}

{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
<r-var name="r" value="0.35"></r-var>
<r-var name="points" value="5"></r-var>
<r-var name="inset" value="2.5"></r-var>
<r-var name="theta" value="0" format=".0%"></r-var>
<r-var name="xC" :value="getCoord(0, theta, 'x', 0, draw)[1] || (-0.5 + r)"></r-var>
<r-var name="yC" :value="getCoord(0, theta, 'y', 0, draw)[1] || 0.5"></r-var>
<r-var name="uX" value="-0.5"></r-var>
<r-var name="uY" value="0.5"></r-var>
<r-var name="zeroX" :value="getCoord(0, theta, 'x', 0, draw)[0]"></r-var>
<r-var name="zeroY" :value="getCoord(0, theta, 'y', 0, draw)[0]"></r-var>
<r-var name="draw" value="false" type="Boolean"></r-var>
<r-var name="drawing" value="false" type="Boolean"></r-var>

<h3>Sin and Cos for Stars</h3>
<p>
  Checkout the <a href="/showcase/unit-circle">unit-circle</a>, as a simpler example.
  This shows that you can integrate with user defined scripts. In this case, we are
  waiting for the green-circle to show up, and then using some SVG functions to
  <code>getPointAtLength</code> along the curve!
</p>
<r-button :click="render({theta: 0, inset:1, points:50, draw: false})" label="Circle"></r-button>
<r-button :click="render({theta: 0, inset:2.5, points:5, draw: false})" label="Star"></r-button>
<r-button :click="render({draw: true})" label="Draw"></r-button>
<r-visible :visible="draw"><aside class="callout">Drag the purple node to create a custom curve!</aside></r-visible>
<p>
  Percent along path: <r-dynamic bind="theta" min="0" step="0.01" :max="1" periodic="true"></r-dynamic>
  <r-visible :visible="!draw && points <= 20">
    Inset: <r-dynamic bind="inset" min="1" step="0.5" :max="10"></r-dynamic>
    Points: <r-dynamic bind="points" min="2" step="1" :max="20"></r-dynamic>
  </r-visible>
</p>

<script>
  // The code is a bit messy, help always welcome .... !
  function render(args) {
    // Requests an update on the chart.
    setTimeout(() => document.getElementById('whatIsYourStarSign').requestUpdate(), 100);
    return args;
  }
  function getTheta(x, y) {
    const angle = Math.atan2(y - 0.5, x + 0.5) / (2 * Math.PI);
    return angle < 0 ? 1 + angle : angle;
  }
  function getRadius(r, x, y) {
    const yN = Math.max(Math.min(Math.abs(y - 0.5), r), 0.01);
    const xN = Math.max(Math.min(Math.abs(x + 0.5), r), 0.01);
    return Math.sqrt(xN * xN + yN * yN)
  }
  function getCoord(t, theta, coord, zero = 0, draw=false) {
    // Zero is a hack, the transform between t and theta is non linear, and I haven't made a transfrom function.
    // Zero just offsets the curve by a bit so that it *starts* at the right place.
    // This is good enough for animations when people aren't really paying attention. :)
    const chart = document.getElementById('whatIsYourStarSign');
    const path = draw ?
      chart.shadowRoot.querySelectorAll('path[stroke="purple"]')[0]
      : chart.shadowRoot.querySelectorAll('path[stroke="green"]')[0];
    if (path == null) return {x:0, y:0}; // This happens on the first render
    const loc = (t + theta) % 1;
    const rawPt = path.getPointAtLength(loc * path.getTotalLength());
    const pt = { x: chart.x.invert(rawPt.x), y: chart.y.invert(rawPt.y) };
    const thetaP = (getTheta(pt.x, pt.y) - theta + 1) % 1;
    return [(thetaP * 2 - zero + 2) % 2, pt[coord]];
  }
  function getShape(r, inset, points) {
    // Returns a star
    const path = [];
    for (let i = 0; i < points * 2 + 1; i++) {
      const rad = (i % 2 === 0 ? r : r / inset);
      const t = Math.PI * 2 / points / 2 * i;
      path.push([Math.cos(t) * rad - 0.5, Math.sin(t) * rad + 0.5]);
    }
    return path;
  }
  // Custom shape path
  const nP = 23;
  const getUserCoord = (i, r) => [Math.cos(i / nP * Math.PI * 2) * r - 0.5, Math.sin(i / nP * Math.PI * 2) * r + 0.5];
  const path = Array(nP).fill(0).map((v, i) => getUserCoord(i, 0.35));
  function setPath(x, y) {
    const t = getTheta(x, y);
    const r = getRadius(0.35, x, y);
    const i = Math.round(t * nP)
    path[i] = getUserCoord(i, r);
    return {
      uX: Math.max(Math.min(x, -0.5 + 0.35), -0.5 - 0.35),
      uY: Math.max(Math.min(y, +0.5 + 0.35), +0.5 - 0.35),
    }
  }
</script>

<r-svg-chart id="whatIsYourStarSign" xlim="[-1, 2]" ylim="[-1, 1]" height="400" width="600" x-axis-location="hidden" y-axis-location="hidden">
  <!-- Create Axis -->
  <r-svg-path :data="[[-1,0],[2, 0],[],[0, -1], [0, 1]]" stroke="#ddd" stroke-width="2"></r-svg-path>
  <r-svg-path :data="[[-1, 0.5-r],[2, 0.5-r],[],[-1, 0.5], [2, 0.5],[],[-1, 0.5+r],[2, 0.5+r]]" stroke="#ddd" stroke-width="0.5"></r-svg-path>
  <r-svg-path :data="[[ 0,-0.5-r],[2,-0.5-r],[],[ 0,-0.5], [2,-0.5],[],[ 0,-0.5+r],[2,-0.5+r]]" stroke="#ddd" stroke-width="0.5"></r-svg-path>
  <r-svg-path :data="[[-0.5-r,1],[-0.5-r,0],[],[-0.5,1], [-0.5,0],[],[-0.5+r,1],[-0.5+r,0]]" stroke="#ddd" stroke-width="0.5"></r-svg-path>
  <!-- Three equations for the bottom-left curve -->
  <r-svg-eqn eqn="[-Math.cos(t)*(-0.5-r), -Math.sin(t)*(-0.5-r)]" parameterize="t" :domain="[Math.PI, Math.PI*1.5]" stroke="#ddd" stroke-width="0.5"></r-svg-eqn>
  <r-svg-eqn eqn="[-Math.cos(t)/-2, -Math.sin(t)/-2]" parameterize="t" :domain="[Math.PI, Math.PI*1.5]" stroke="#ddd" stroke-width="0.5"></r-svg-eqn>
  <r-svg-eqn eqn="[-Math.cos(t)*(-0.5+r), -Math.sin(t)*(-0.5+r)]" parameterize="t" :domain="[Math.PI, Math.PI*1.5]" stroke="#ddd" stroke-width="0.5"></r-svg-eqn>
  <!-- Guidelines from the current point (xC,yC) -->
  <r-svg-path :visible="!drawing" :data="[[xC, yC], [0, yC]]" stroke="red" stroke-width="1"></r-svg-path>
  <r-svg-path :visible="!drawing" :data="[[xC, yC], [xC, 0]]" stroke="blue" stroke-width="1"></r-svg-path>
  <r-svg-eqn :visible="!drawing" eqn="[-Math.cos(t)*xC, -Math.sin(t)*xC]" parameterize="t" :domain="[Math.PI, Math.PI*1.5]" stroke="blue" stroke-width="1"></r-svg-eqn>
  <!-- Text labels -->
  <r-svg-text text="sin-ish(&theta;)" x="1.6" :y=" 0.43-r" fill="red"></r-svg-text>
  <r-svg-text text="cos-ish(&theta;)" x="1.6" :y="-0.57-r" fill="blue"></r-svg-text>
  <!-- A circle! -->
  <r-svg-path :data="getShape(r, inset, points)" :visible="!draw" stroke="green" stroke-width="2"></r-svg-path>
  <!-- Offset sin and cos waves -->
  <r-svg-eqn :visible="!drawing" eqn="getCoord(t, theta, 'y', zeroY, draw)" :samples="draw? 100 : 500" parameterize="t" domain="[0.001, 0.999]" stroke="red" stroke-width="3"></r-svg-eqn>
  <r-svg-eqn :visible="!drawing" eqn="getCoord(t, theta, 'x', zeroX, draw)" :samples="draw? 100 : 500" parameterize="t" domain="[0.001, 0.999]" stroke="blue" stroke-width="3"></r-svg-eqn>
  <!-- A drag node to change the offset -->
  <r-svg-node :x="xC" :y="yC" fill="green" :visible="!draw" :drag="{theta: getTheta(x,y), play:false}"></r-svg-node>
  <!-- Drawing lines and nodes -->
  <r-svg-path :data="path" :visible="draw" stroke="purple" stroke-width="2" curve="basis" closed="true"></r-svg-path>
  <r-svg-node :x="uX" :y="uY" :visible="draw" fill="purple" :drag="setPath(x,y)" :dragging="{drawing: value}"></r-svg-node>
  <r-svg-circle :visible="!drawing && draw" :x="xC" :y="yC" fill="black"></r-svg-circle>
</r-svg-chart>
<aside><p>There is a joke in here somewhere about finding your <strong>star sign</strong> 🦂 ... !</p></aside>
{% endblock%}

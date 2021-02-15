{% extends "layout/article.tpl" %}
{% block article %}
<h1>@curvenote/svg</h1>
<r-outline class="popout"></r-outline>

<p>To create an svg diagram or simple chart, use the <code>&lt;r-svg-chart&gt;</code> component and add a few children to see the plotting of equations, lines and points.</p>

<r-demo>
  <r-var name="beat" value="1"></r-var>
  <p style="text-align:center;">
    <r-svg-chart xlim="[-20, 20]" ylim=[-20,20] xlabel="x" ylabel="love(x)">
      <r-svg-eqn eqn="[beat * (16 * Math.pow(Math.sin(t), 3)), beat * (13* Math.cos(t) - 5 * Math.cos(2 * t) - 2 * Math.cos(3 * t) - Math.cos(4 * t))]" parameterize="t" :domain="[0, 2*Math.PI]" stroke="red" stroke-width="3" :listen="beat"></r-svg-eqn>
    </r-svg-chart>
    See the heart beat: <r-range bind="beat" min="0.25" max="1.75" step="0.01"></r-range>
  </p>
</r-demo>

<hr>

<h2>Getting Started</h2>

<p>
    Let's start with a simple sin wave, that is, we want a line defined as $f(x) = \sin(x)$. And then explore some of the dynamic properties of the chart.
</p>
<r-demo>
  <r-svg-chart xlabel="x" ylabel="sin(x)" xlim="[-6.28, 6.28]" ylim="[-1,1]" x-axis-location="origin" y-axis-location="origin">
    <r-svg-eqn eqn="Math.sin(x)"></r-svg-eqn>
  </r-svg-chart>
</r-demo>

<h3>r-svg-chart properties</h3>

<aside class="callout">
  SVG Chart Properties:
  <dl>
    <dt><code>xlabel</code></dt><dd>The x-axis label.</dd>
    <dt><code>ylabel</code></dt><dd>The y-axis label.</dd>
    <dt><code>xlim</code></dt><dd>The x-axis limits, a list of two numbers. Can be set dynamically with <code>:xlim</code>.</dd>
    <dt><code>ylim</code></dt><dd>The y-axis limits, a list of two numbers. Can be set dynamically with <code>:ylim</code>.</dd>
    <dt><code>x-axis-location</code></dt><dd>Can be set to <code>origin</code>.</dd>
    <dt><code>y-axis-location</code></dt><dd>Can be set to <code>origin</code>.</dd>
  </dl>
</aside>


<r-scope name="limits">
  <h3><code>xlim</code> and <code>:xlim</code></h3>
  <p>First, let's manipulate and dynamically update the <code>xlim</code> of the chart. We will make it hooked up to two variables that control the domain extents. Start by creating some variables:</p>
  <r-demo code-only>
    <r-var name="domainStart" value="-5"></r-var>
    <r-var name="domainEnd" value="5"></r-var>
  </r-demo>

  <p>
    Next we need to go from a static declaration of the <code>xlim</code>, to it being computed every time by referencing these two variables. We can use the <code>:xlim</code> property to do this.
    We will also put in two <code>&lt;r-range&gt;</code> properties to control the variables declared above.
  </p>

  <r-code compact language="html">&lt;r-svg :xlim="[domainStart, domainEnd]"&gt;</r-code>

  <p>This is also quite handy even if you are setting to <code>2 * Math.PI</code>, this can also be dynamically evaluated. Try changing the domain of the plot below!</p>
  <r-demo>
    <p style="text-align: center;">
      <r-svg-chart :xlim="[domainStart, domainEnd]" ylim="[-1.2, 1.2]" width="400" height="400" x-axis-location="origin" y-axis-location="origin">
        <r-svg-eqn eqn="Math.sin(x)"></r-svg-eqn>
      </r-svg-chart>
      Start: <r-range bind="domainStart" :min="-Math.PI * 4" max="0" step="0.01"></r-range>
      End: <r-range bind="domainEnd" :max="Math.PI * 4" min="0" step="0.01"></r-range>
    </p>
  </r-demo>
</r-scope>

<h2>All Chart Components</h2>

<r-scope name="radial">
  <r-demo>
    <r-var name="a" value="3"></r-var>
    <r-var name="b" value="3"></r-var>
    <r-var name="r" :value="Math.sqrt(a*a + b*b)"></r-var>
    <r-svg-chart xlim="[-5, 5]" ylim="[-5, 5]" height="400" width="400" x-axis-location="origin" y-axis-location="origin" style="text-align: center;">
      <r-svg-eqn :domain="[0, Math.atan2(b, a)]" eqn="[r * Math.cos(t), r * Math.sin(t)]" parameterize="t" stroke="#333" stroke-width="1" stroke-dasharray="3"></r-svg-eqn>
      <r-svg-path :data="[[0, 0],[r * Math.cos(Math.atan2(b, a)), r * Math.sin(Math.atan2(b, a))]]" stroke="#333" stroke-width="1" stroke-dasharray="3"></r-svg-path>
      <r-svg-text :x="(r/2) * Math.cos(Math.atan2(b, a) / 2)" :y="(r/2) * Math.sin(Math.atan2(b, a) / 2)" :text="Math.round(Math.atan2(b, a)*180/Math.PI) + '&deg;'"></r-svg-text>
      <r-svg-node :x="a" :y="b" :drag="{a: x, b: y}"></r-svg-node>
    </r-svg-chart>
  </r-demo>
</r-scope>

<aside class="callout">
  <strong>Chart Components:</strong>
  <dl>
    <dt><code>r-svg-circle</code></dt><dd>An SVG circle that can control <code>x</code> and <code>y</code> location, color, radius and other standard svg circle properties.</code>.</dd>
    <dt><code>r-svg-path</code></dt><dd>An SVG path that can control <code>data</code> (an array of <code>[x, y]</code>), stroke and other standard svg path properties.</code>.</dd>
    <dt><code>r-svg-text</code></dt><dd>An SVG text that can control <code>x</code> and <code>y</code> location, color and other standard svg text properties.</code>.</dd>
    <dt><code>r-svg-eqn</code></dt><dd>An SVG path that is parameterized by a function (<code>eqn</code>) and controls stroke, color and other standard svg path properties.</code>.</dd>
    <dt><code>r-svg-node</code></dt><dd>An interactive node that can be dragged. Can control stroke, color and other standard svg circle properties.</code>.</dd>
  </dl>
</aside>

<p>The <code>render</code> function of the chart loops through all of the children and renders the SVG template. Each <code>r-svg</code> child has to return an SVG namespaced string to add to the chart. In this way, they keep the same ordering as the dom</p>
<r-code language="js" compact>
  render() {
    return html`
      &lt;svg width="$&lbrace;this.width}" height="$&lbrace;this.height}"&gt;
      $&lbrace;this.children.map(child =&gt;{
        return child.renderSVG(this);
      })}
      &lt;/svg&gt;
    `;
  }
</r-code>

<p>
  Each child component has a <code>renderSVG</code> function that returns an svg template string.
</p>

<h2><code>r-svg-eqn</code> - Changing equations</h2>
<r-scope name="eqn">
  <p>
    The <code>r-svg-eqn</code> component allows you to create dynamic lines or points based on an equation.
    This allows you to create and show equations like <code>Math.sin(x)</code>.
    The equation is computed by evaluating a string, if we want it to be dynamically set, we can use another variable (e.g. <code>func</code>) to set it.
  </p>
  <r-demo code-only>
    <r-var name="func" value="Math.sin(x)" type="String"></r-var>
  </r-demo>

  <p>It is important that you update the <code>:eqn</code> function to <emph>compute</emph> the string rather than use the string <code>"func"</code> directly, which will error.</p>
  <r-code compact language="html">&lt;r-svg-eqn :eqn="func"&gt;</r-code>

  <r-demo>
    <p style="text-align: center;">
      <r-svg-chart xlim="[-5, 5]" ylim="[-1.2, 1.2]" width="750" height="400" x-axis-location="origin" y-axis-location="origin">
        <r-svg-eqn :eqn="func"></r-svg-eqn>
      </r-svg-chart>
      <r-button :click="{func: 'Math.cos(x)'}" label="Cos" :disabled="func === 'Math.cos(x)'"></r-button>
      <r-button :click="{func: 'Math.sin(x)'}" label="Sin" :disabled="func === 'Math.sin(x)'"></r-button>
      <r-button :click="{func: 'Math.tan(x)'}" label="Tan" :disabled="func === 'Math.tan(x)'"></r-button>
      <r-button :click="{func: 'x * Math.sin(x + 1) / 10'}" label="Weird"></r-button><br>
      <r-input :change="{func: value}" :value="func"></r-input><br>
    </p>
  </r-demo>

  <p>
    You can also <code>parameterize</code> the function over <code>x</code>, <code>y</code> or <code>t</code>.
    When parameterizing in terms of <code>t</code> you must supply a <code>domain</code> (e.g. <code>[0, 1]</code>) and the function
    should return a length-two list. Both <code>x</code> and <code>y</code> parameterizations provide the other coordinate
    so the function should only return a number.
  </p>

  <r-demo>
    <r-var name="amplitude" value="0.4"></r-var>
    <p style="text-align: center;">
      <r-svg-chart :xlim="[-5, 5]" ylim="[-5, 5]" width="400" height="400" x-axis-location="origin" y-axis-location="origin">
        <r-svg-eqn eqn="amplitude * Math.sin(x)" :listen="amplitude"></r-svg-eqn>
        <r-svg-eqn eqn="amplitude * Math.sin(y)" parameterize="y"></r-svg-eqn>
        <r-svg-eqn eqn="[amplitude*t * Math.cos(t), amplitude*t * Math.sin(t)]" parameterize="t" :domain="[0,Math.PI*16]"></r-svg-eqn>
      </r-svg-chart>
      <strong>Amplitude:</strong><r-range bind="amplitude" min="-5" max="5" step="0.05"></r-range><br>
    </p>
  </r-demo>

  <aside class="callout danger">
    <p>
      <strong>Note:</strong> You ocasionally have to <code>:listen</code> for changes in the <code>r-svg-eqn</code> component,
      as the eqn attribute is a string and does not trigger updates to the chart. The <code>:listen</code> attribute can be a
      single value, or an array of values to listen to and re-draw the chart.
    </p>
  </aside>
</r-scope>


<r-scope name="phase">
  <h2>Example - Sin Wave</h2>

  <r-var name="amplitude" value="1"></r-var>
  <r-var name="freq" value="1"></r-var>
  <r-var name="phase" value="0"></r-var>

  <strong>Amplitude, $A$:</strong><r-dynamic bind="amplitude" min="-3" max="3" step="0.25"></r-dynamic><br>
  <strong>Frequency, $f$:</strong><r-dynamic bind="freq" min="0" max="6.28" step="0.2"></r-dynamic><br>
  <strong>Phase, $\varphi$:</strong><r-dynamic bind="phase" min="0" :max="freq * ((Math.PI * 2) ** 2)" step="0.25"></r-dynamic><br>

  <r-equation>
    y(t) = A \cos(2 \pi f t - \varphi)
  </r-equation>

  <r-svg-chart :xlim="[0, 2 * Math.PI]" ylim="[-3, 3]" xlabel="t" ylabel="y(t)">
    <r-svg-eqn eqn="amplitude * Math.cos(2 * Math.PI * freq * x - phase)"></r-svg-eqn>
    <r-svg-node :x="phase / (2 * Math.PI * freq)" :y="amplitude" :drag="{amplitude: y, phase: 2 * Math.PI * freq * x}"></r-svg-node>
  </r-svg-chart>
</r-scope>

<r-scope name="dragOffset">
  <h2>Example - Drag Nodes</h2>

  <r-var name="a" value="0.5"></r-var>
  <r-var name="b" value="0.5"></r-var>

  <r-var name="off_x" value="0.5"></r-var>
  <r-var name="off_y" value="0.5"></r-var>

  <strong>$A$:</strong><r-dynamic bind="a" min="-3" max="3" step="0.25"></r-dynamic><br>
  <strong>$B$:</strong><r-dynamic bind="a" min="-3" max="3" step="0.25"></r-dynamic><br>
  <strong>$x$:</strong><r-dynamic bind="off_x" min="-1" max="1" step="0.1"></r-dynamic><br>
  <strong>$y$:</strong><r-dynamic bind="off_y" min="-1" max="1" step="0.1"></r-dynamic><br>

  <r-demo>
    <r-svg-chart xlim="[-3, 3]" ylim="[-3, 3]">
      <r-svg-text :x="a" :y="b" text="(a, b)"></r-svg-text>
      <r-svg-text :x="a + off_x" :y="b + off_y" text="(a + x, b + y)"></r-svg-text>
      <r-svg-node :x="a" :y="b" :drag="{a: x, b: y}"></r-svg-node>
      <r-svg-node :x="a + off_x" :y="b + off_y" :drag="{off_x: x - a, off_y: y - b}"></r-svg-node>
    </r-svg-chart>
  </r-demo>
</r-scope>

<r-scope name="addWaves">
  <h2>Example - Adding Sin and Cos</h2>

  <r-var name="amplitude1" value="1"></r-var>
  <r-var name="freq1" value="1"></r-var>
  <r-var name="phase1" value="0"></r-var>

  <r-var name="amplitude2" value="1"></r-var>
  <r-var name="freq2" value="1"></r-var>
  <r-var name="phase2" value="0"></r-var>

  <h2 data-outline="none">Sin</h2>
  <strong>Amplitude, $A$:</strong><r-dynamic bind="amplitude1" min="-3" max="3" step="0.05"></r-dynamic><br>
  <strong>Frequency, $f$:</strong><r-dynamic bind="freq1" min="0" max="6.28" step="0.05"></r-dynamic><br>
  <strong>Phase, $\varphi$:</strong><r-dynamic bind="phase1" min="-10" max="10" step="0.05" periodic="true"></r-dynamic><br>


  <h2 data-outline="none">Cos</h2>
  <strong>Amplitude, $A$:</strong><r-dynamic bind="amplitude2" min="-3" max="3" step="0.05"></r-dynamic><br>
  <strong>Frequency, $f$:</strong><r-dynamic bind="freq2" min="0" max="6.28" step="0.05"></r-dynamic><br>
  <strong>Phase, $\varphi$:</strong><r-dynamic bind="phase2" min="-10" max="10" step="0.05" periodic="true"></r-dynamic><br>

  <r-equation>
    y(t) = A \sin(2 \pi f t - \varphi)
  </r-equation>

  <r-svg-chart :xlim="[0, 10]" ylim="[-6, 6]" xlabel="t" ylabel="f(t)">
    <r-svg-eqn eqn="amplitude1 * Math.sin(2 * Math.PI * freq1 * x - phase1)" :listen="[amplitude1, amplitude2, freq1, freq2, phase1, phase2]"></r-svg-eqn>
    <r-svg-eqn eqn="amplitude2 * Math.cos(2 * Math.PI * freq2 * x - phase2)"></r-svg-eqn>
    <r-svg-eqn eqn="amplitude1 * Math.sin(2 * Math.PI * freq1 * x - phase1) + amplitude2 * Math.cos(2 * Math.PI * freq2 * x - phase2)" stroke-width="2.5"></r-svg-eqn>
  </r-svg-chart>
</r-scope>

{% endblock%}

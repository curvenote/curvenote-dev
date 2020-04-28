{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>@iooxa/components</h1>
<r-outline class="popout"></r-outline>
<h2>Introduction</h2>
<p>
  The <code>@iooxa/components</code> package comes with a number of web-components for interative scientific writing.
  Variables need to be defined to drive your dynamic document, the <code>r-var</code> web component
  can specify a <code>name</code> and a <code>value</code> as attributes.
  In the following example, we will create reactive variables for $x$ and $y$ and then control them with
  sliders and dynamic text.
</p>
<r-scope name="demoVars">
  <r-demo>
    <r-var name="x" value="2" format=".0f"></r-var>
    <r-var name="y" value="4" format=".0f"></r-var>
    <r-var name="xy" :value="x * y" format=".0f"></r-var>
    <p>
      If we have ranges for two variables:<br>
      X: <r-range bind="x" max="10"></r-range>, which is <r-display bind="x"></r-display><br>
      Y: <r-range bind="y" max="10"></r-range>, which is <r-display bind="y"></r-display><br>
      Or you can set the value directly in the text for X= <r-dynamic bind="x"></r-dynamic> and Y= <r-dynamic bind="y"></r-dynamic>.<br>
      The product of X and Y is <r-display bind="xy"></r-display>.
    </p>
  </r-demo>
  <p>
    Here we have created three variables, one of which (<code>xy</code>) will update when
    either <code>x</code> or <code>y</code> is changed!
    The text is just normal <code>html</code> and we can interleave some reactive inputs to
    change the values of <code>x</code> or <code>y</code>.
    Also included in the example are a <code>&lt;r-range&gt;</code> and a <code>&lt;r-dynamic&gt;</code>,
    which correspond to a slider and dynamic text, respectively.
  </p>

  <h2>Reactive Variables</h2>
  <p>
    The syntax to create a reactive variable is simply writing the following HTML and including it
    in your page:
  </p>
  <r-code language="html" compact>&lt;r-var name="x" value="1"&gt;&lt;/r-var&gt;</r-code>
  <script>
    function toggleVarVisible(show) {
      Array.from(document.querySelectorAll('r-var')).forEach(e => { e.style.display = show ? 'block' : 'none'; });
      return { show };
    }
  </script>

  <r-var name="show" value="false" type="Boolean"></r-var>
  <p>
    These variables are hidden in the <code>DOM</code> by default, you can change the styles globally or
    by changing the style to include <code>display: block</code>.
  </p>
  <aside>
    <r-switch :value="show" :change="toggleVarVisible(value)" label="Show Variables"></r-switch>
  </aside>

  <p>
    You can also create reactive variables which will execute a <strong>user-defined string</strong> with access
    to all other variables in the scope <code>r-scope</code> (more on that below!).
    Note here that the <code>:value</code> has a <em>semi-colon</em> to show that this should
    be executed to define the value.
  </p>

  <r-code language="html" compact>&lt;r-var name="xy" :value="x * y"&gt;&lt;/r-var&gt;</r-code>

  <p>
    As you might expect, this will multiply $x$ and $y$, and store the result in the variable <code>xy</code>.
  </p>

  <hr>

  <h2>Display Variables</h2>

  <p>
    To display an element create an <code>r-display</code>, which will just render <code>value</code> as text.
    As before, the syntax <code>:value</code> will evaluate the string and store the result.
  </p>

  <r-code language="html" compact>&lt;r-display :value="x"&gt;&lt;/r-display&gt;</r-code>

  <p>
    Remember that $x$ is a number that is <strong><r-display :value="Array(Math.min(Math.round(x), 5)).fill('r').join('')"></r-display></strong>reactive: <r-display bind="x"></r-display>.<br>
    Try setting the value of $x$ with the range input: <r-range bind="x" max="5"></r-range>
  </p>

  <p>
    You can also <code>:transform</code> the value of a variable before you format it.
    For example, you might want to say that the admission to a park is <code>'free'</code> when the
    <r-action :click="{x:0}">value == 0</r-action>.
  </p>
  <r-demo>
    <p>
      The park admission is
      <r-display :value="x" :transform="(value > 0)? value : 'free 🎉'" format="$.2f"></r-display>.
    </p>
  </r-demo>
  <p>
    You can also use this <code>:transform</code> to say that the park admission is
    <r-dynamic bind="x" :transform="['free','real cheap','cheap','costly','expensive','real expensive'][Math.min(Math.max(Math.round(value),0),5)]" max="5"></r-dynamic>
    .<br>
    This is also quite useful if you want to use the transform to index into an array <r-dynamic bind="x"
      :transform="['&#128525;','&#128516;','&#128522;','&#128528;','&#128530;','&#128532;'][Math.min(Math.max(Math.round(value),0),5)]"
      max="5"></r-dynamic>, in this case emoji array - but it could be numeric too!
  </p>

  <hr>

  <h2>Controlling Variables</h2>

  <aside>
    <p>You can also control variables through diagrams and other custom components!!</p>
    <r-var name="cX" :value="Math.min(Math.max(x, 0), 10)"></r-var>
    <r-var name="cY" :value="Math.min(Math.max(y, 0), 10)"></r-var>
    <r-svg-chart width="200" height="200" xlim="[-2, 12]" ylim="[-2, 12]" x-axis-location="hidden" y-axis-location="hidden">
      <r-svg-text x="-0.7" :y="cY - 0.5" :text="Math.round(cY)" fill="#aaa" text-anchor="end"></r-svg-text>
      <r-svg-text x="10.7" :y="cY - 0.5" text="y" fill="#aaa" text-anchor="start"></r-svg-text>
      <r-svg-text :x="cX" y="-1.4" :text="Math.round(cX)" fill="#aaa" text-anchor="middle"></r-svg-text>
      <r-svg-text :x="cX" y="10.6" text="x" fill="#aaa" text-anchor="middle"></r-svg-text>
      <r-svg-path :data="[[0,cY],[10,cY],[],[cX,0],[cX,10]]" stroke="#aaa"></r-svg-path>
      <r-svg-node :x="cX" :y="cY" :drag="{x: Math.min(Math.max(x, 0), 10), y:Math.min(Math.max(y, 0), 10)}"></r-svg-node>
    </r-svg-chart>
  </aside>
  <p>
    What gets slightly more exciting is when you can bring these together with inputs that can be ranges or dynamic text
    elements that you can drag. This can be setup most easily using the <code>bind</code> attribute:
  </p>

  <r-code language="html" compact>&lt;r-dynamic bind="x"&gt;&lt;/r-dynamic&gt;</r-code>

  <p>
    This allows you to set the value of $x$ inline: <r-dynamic bind="x"></r-dynamic> or $y=$<r-dynamic bind="y">
    </r-dynamic>. Or create a slider over a range:
    <br>$x:$<r-range bind="x" max="10"></r-range><br>
    Notice how all components update reactively to the <code>r-range</code> and <code>r-display</code> 🚀.
  </p>
  <p>
    For the <code>&lt;r-dynamic&gt;</code> component you can also add text inside of the dynamic text,
    for example, <r-dynamic bind="y" after="ºC"></r-dynamic>,
    includes an <code>after="ºC"</code> attributes.
  </p>
  <r-code language="html" compact>&lt;r-dynamic bind="y" after="ºC"&gt;&lt;/r-dynamic&gt;</r-code>
  <aside>
    <p>Here the final range has a <code>max</code> of 10, while the other two ranges have a <code>max</code> of 5!</p>
    <p>
      $x_{5} :$ <r-range style="margin: 15px;" bind="x" max="5"></r-range>
      <r-display bind="x"></r-display><br>
      $y_{5} :$ <r-range style="margin: 15px;" bind="y" max="5"></r-range>
      <r-display bind="y"></r-display><br>
      $y_{10}:$ <r-range style="margin: 15px;" bind="y" max="10"></r-range>
      <r-display bind="y"></r-display><br>
    </p>
  </aside>
  <p>
    You can also create ranges with identical syntax:
  </p>
  <r-code language="html" compact>&lt;r-range bind="x"&gt;&lt;/r-range&gt;</r-code>


  <h3>Events and Bind Syntax</h3>

  <p>
    There are times where you want more control over how your data gets displayed, updated or informs other variables.
    In the code above we have actually taken a shortcut to <code>bind</code> a range or dynamic text to
    a named variable. This amounts to the default <strong>two way connection</strong>:
  </p>
  <r-code language="html">
    &lt;r-dynamic
      bind="x"
    &gt;&lt;/r-dynamic&gt;
  </r-code>
  <p>
    When the variable <code>x</code> updates, the <code>value</code> is set, and when the control sends a <code>change</code> event,
    the udpated value is set to the variable <code>x</code>!
    Under the hood, when the <code>bind</code> attribute is defined, the <code>:value</code> and the <em>default event</em> (e.g. <code>:change</code>) functions are
    automatically set.
  </p>
  <aside><p>The <code>bind</code> function also copies over the <code>format</code>, which means you can define the format string once!</p></aside>

  <r-code language="html">
    &lt;r-dynamic
      :value="x"
      :change="{ x: value }"
    &gt;&lt;/r-dynamic&gt;
  </r-code>
  <p>
    As with other properties, the <code>:</code> syntax for the <code>value</code> property recomputes every time there is
    a change.
    For example, if you put <code>:value="x"</code> then anytime the variable <code>x</code> changes, the value of the
    control updates.
    <strong>However, this is not the case in reverse!</strong>
    You have to explicitly hook up to the <code>:change</code> event to change the variable (or variables) you want to update.
    This is done using a JSON dictionary of the form:
    <br><code>{ variable: value }</code><br>
    You can think of this as the following function:
  </p>
  <r-code language="javascript">
    function change(value) {
      return { "x": value };
    }
  </r-code>
  <p>
    Both the name of the event, as well as the arguments are specific to the component, for example,
    a drag-node in a chart might have the function:
  </p>
  <r-code language="javascript">
    function drag(x, y) {
      return { "phase": x, "amplitude": y / 300 };
    }
  </r-code>
  <aside>
    <p>
      For example, check out <a href="/showcase/coordinate-transform">changing between radial and cartiesian coordinates</a> in the showcase.
    </p>
    <img src="/images/showcase/coordinate-transform.gif">
  </aside>
  <p>
    As in the example above, you can update <em>multiple variables</em> at a time. If you choose to explicitly set these, and not just use the <code>bind</code> property, you can do some interesting
    things!
  </p>
</r-scope>

<h2>Scopes</h2>
<blockquote>
  <p>Namespaces are one honking great idea -- let's do more of those!</p>
  <footer>
  <cite><a target="_blank" href="https://www.python.org/dev/peps/pep-0020/">Tim Peters</a></cite>
  <time>August 2004</time>
  </footer>
</blockquote>
<p>
  The <code>r-scope</code> component allows you to split your document into logical blocks, and
  keep the variables in that scope distinct.
</p>
<r-demo>
  <r-scope name="hello">
    <h4 data-outline="none">Scope: 👋</h4>
    <!-- Create a variable in the "hello" scope: -->
    <r-var name="foo" value="1" style="display: block;"></r-var>
    <p>
      The value of <code>foo</code> is <r-display :value="foo"></r-display>.<br>
      The value of <code>bar</code> is <r-display :value="bar"></r-display>.
    </p>
  </r-scope>
  <r-scope name="world">
    <h4 data-outline="none">Scope: 🌎</h4>
    <!-- Create another variable in the "world" scope: -->
    <r-var name="foo" value="42" style="display: block;"></r-var>
    <r-var name="bar" value="1" style="display: block;"></r-var>
    <p>
      The value of <code>foo</code> is <r-display :value="foo"></r-display>.<br>
      The value of <code>bar</code> is <r-display :value="bar"></r-display>.
    </p>
  </r-scope>
</r-demo>
<p>
  The scope <strong>must have a name</strong>, although it doesn't have to be unique.
  For example, if you want to add other elements or variables to that scope later on:
</p>
<r-demo>
  <!-- This is referencing the **same** scope as above!! -->
  <r-scope name="world">
    <h4 data-outline="none">Scope: 🌎</h4>
    <!-- No `foo` defined here! -->
    🌎<r-range bind="foo"></r-range>
  </r-scope>
</r-demo>

<p>You can also update variables in other scopes:</p>
<r-scope name="moon">
  <aside>
    <p>
      That means you can also play with the phases of the emoji-moon:<br>
      <span style="font-size: xx-large;">
        <r-dynamic bind="foo" max="7" periodic="true"
          :transform="['🌘', '🌗', '🌖', '🌕', '🌔', '🌓', '🌒', '🌑'][(Math.round(value) + 7 )% 7]"></r-dynamic>
      </span>
    </p>
  </aside>
</r-scope>
<r-demo>
  <!-- Update foo in the world scope! -->
  <r-scope name="moon">
    <h4 data-outline="none">Scope: 🌝</h4>
    <r-var name="foo" value="42" style="display: block;"></r-var>
    🌝<r-range bind="foo" max="7"></r-range>
    🌎<r-range :value="$variables.world.foo" :change="{'world.foo': value}"></r-range>
  </r-scope>
</r-demo>

<p>
  That's it for an overview of using <code>@iooxa/components</code>, next up, is
  seeing the components that you have available to you out of the box!
</p>

<a href="/article" style="text-decoration: none; float: left;">
  <r-button outlined label="< article"></r-button>
</a>
<a href="/components/overview" style="text-decoration: none; float: right;">
  <r-button outlined label="overview of components >"></r-button>
</a>

{% endblock%}

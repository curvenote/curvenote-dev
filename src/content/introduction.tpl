{% extends "layout/article.tpl" %}
{% block article %}
<h1>Introduction</h1>
<r-outline class="popout"></r-outline>
<!-- CURVENOTE https://api.curvenote.com/blocks/CgfG3BXYMgMzS5Dzook2/xiNiWaRH0ogcRY4pSQIT -->
  <p>
    We think that creating beautiful reactive documents and explorable explanations should be easy. Writing technical
    documents is hard enough already, and choosing to make that writing <em>interactive</em> is beyond the reach of most
    communicators - who often have limited or no development experience.
  </p>
  <p>
    Providing multiple visuals of images, text, and equations that are all interconnected allows your readers to
    interrogate models, build intuition and <em>play</em> with ideas. Not every explanation is best suited to be augmented
    with interactive content, however, not every explanation is best represented by paper, or the computer simulated
    version: the PDF.
  </p>
  <p>
    We are working on <a href="https://curvenote.com">an editor and publishing platform</a> to try to lower the barriers
    around creating reactive documents and are committed to the core of these documents being open source, so you can take
    your documents anywhere. <code>curvenote.dev</code> is a collection of open source tools and packages that aim to lower
    the barrier to interactive scientific writing.
  </p>
<!-- /CURVENOTE -->

<hr>

<h2 id="tangled-cookies">Tangled Cookies</h2>
{% include 'content/untangle.tpl' %}

<hr>

<h2>Overview</h2>

<!-- CURVENOTE https://api.curvenote.com/blocks/CgfG3BXYMgMzS5Dzook2/qkL20MSIechpmsfhlUbf -->
<p>
  There are a few things going on in the above example! The example is supported by four packages:
  <ul>
    <li><p><code>@curvenote/runtime</code> keeps track of the reactive state of the page</p></li>
    <li><p><code>@curvenote/components</code> reactive components for text, inputs, sliders, equations, code, etc.</p></li>
    <li><p><code>@curvenote/svg</code> reactive svg components for simple interactive diagrams</p></li>
    <li><p><code>@curvenote/article</code> bundles together all of the above, and provides CSS layouts</p></li>
  </ul>
</p>
<!-- /CURVENOTE -->

<a href="/components" style="text-decoration: none; float: right;"><r-button outlined label="components docs"></r-button></a>
<h3>@curvenote/components</h3>

<aside class="margin">
  <p>
    For more information on why we chose web-components,
    and how this works with other frameworks (it does!), check out our blog.
  </p>
</aside>
<p>
  The <code>@curvenote/components</code> package provides many <strong>r</strong>eactive web-components
  that work with the <strong>r</strong>untime package (which is based on <strong>r</strong>edux).
  With so many <strong>r</strong>'s, we decided to use this p<strong>r</strong>efix to denote these <strong>r</strong>eactive components.
  For example, <code>&lt;r-var&gt;</code> creates a <strong>r</strong>eactive variable, and
  <code>&lt;r-display&gt;</code> will display the up-to-date value or that variable.
</p>

<r-scope name="rVar">
  <r-demo>
    <r-var name="myFirstVariable" value="42" format=".0f"></r-var>
    <p>
      The most special number is <r-display bind="myFirstVariable"></r-display>.
    </p>
  </r-demo>
  <aside class="margin">
    <p>
      We know this is still a little hard, which is why we are working on an <a href="https://github.com/curvenote/editor">editor</a> to make writing very easy!!
      <img src="/images/var-editor.gif" style="border: 1px solid #333;"><br>
      Sign up to <a href="{{ site.main }}" target="_blank">curvenote.com</a> to give it a try! 🚀
    </p>
  </aside>
  <p>
    To learn more about reactive variables, please see the <a href="/components">components documentation</a>,
    where you will learn how to <r-action :click="{myFirstVariable: Math.random() * 100}">update values</r-action>,
    transform text, have dynamic text (<r-dynamic bind="myFirstVariable"></r-dynamic>), add sliders (<r-range bind="myFirstVariable"></r-range>),
    show equations <r-equation inline>(x = <r-display bind="myFirstVariable">)</r-display>)</r-equation>,
    and much more!
  </p>
</r-scope>

<hr>

<a href="/article" style="text-decoration: none; float: right;"><r-button outlined label="article docs"></r-button></a>
<h3>@curvenote/article</h3>
<aside class="margin">
  <p>
    The <code>@curvenote/article</code> library also includes styles!
    So you can write in the margins, or callout important things!
  </p>
</aside>
<p>To get started can put this javascript and css bundle in your page:</p>
<r-code compact copy>
  &lt;link rel="stylesheet" href="https://unpkg.com/@curvenote/article/dist/curvenote.css"&gt;
  &lt;script src="https://unpkg.com/@curvenote/article"&gt;&lt;/script&gt;
</r-code>

<p>
  You can also download the <a href="https://github.com/curvenote/article/releases" target="_blank">latest release</a> from GitHub.
  If you are running this <emph>without</emph> a web server, ensure the script has <code>charset="utf-8"</code> in
  the script tag.
</p>


<a href="/svg" style="text-decoration: none; float: right;"><r-button outlined label="svg docs"></r-button></a>
<h3>@curvenote/svg</h3>

<p>
  The <code>svg</code> package provides a light wrapper on some commonly used <code>&lt;svg&gt;</code>
  elements as well as leveraging <code>d3</code> to create paths, drag-nodes and equations.
  The goal is to make it easy to create simple interactive graphics, but not to provide all the functionality
  that you would expect from a charting library. For that we (will!) provide a wrapper to Vega, or you can help out
  by contributing other extensions that use the <code>runtime</code> library!
</p>

<r-scope name="ymxb">
  <aside class="margin">
    <r-var name="m" value="1"></r-var>
    <r-var name="b" value="1"></r-var>
    <p>$m$ = <r-range bind="m" min="-10" max="10"></r-range>
      <r-display bind="m"></r-display>
    </p>
    <p>$b$ = <r-range bind="b" min="-10" max="10"></r-range>
      <r-display bind="b"></r-display>
    </p>
    <r-equation aligned>
      y &= m \times x + b \\
      y &=
      <r-display :value="m==-1 || m == 0 || m == 1? '' : m" format=".0f"></r-display>
      <r-visible :visible="m == -1">-</r-visible>
      <r-visible :visible="m !== 0">x</r-visible>
      <r-display :value="b==0? '' : b" :format="m==0 ? '.0f' : '+.0f'">+1</r-display>
      <r-visible :visible="m == 0 && b ==0">0</r-visible>
    </r-equation>
  </aside>
  <r-demo>
    <r-svg-chart width="300" height="300" x-axis-location="origin" y-axis-location="origin" xlim="[-10,10]" ylim="[-10,10]">
      <r-svg-eqn eqn="m*x + b" :listen="[m, b]"></r-svg-eqn>
      <r-svg-eqn eqn="m/10*x**2 + b" :listen="[m, b]"></r-svg-eqn>
      <r-svg-node x="0" :y="b" :drag="{b: y}"></r-svg-node>
      <r-svg-node x="5" :y="m*5 + b" :drag="{m: (y - b) / 5}"></r-svg-node>
      <r-svg-node x="-5" :y="m/10*25 + b" :drag="{m: (y - b) / 25 * 10}"></r-svg-node>
    </r-svg-chart>
  </r-demo>
</r-scope>

<a href="/runtime" style="text-decoration: none; float: right;"><r-button outlined label="runtime docs"></r-button></a>
<h3>@curvenote/runtime</h3>

<p>
  The <code>@curvenote/runtime</code> library allows you to create variables and components that react to changes in state through
  <strong>user-defined</strong> functions. The runtime is a small component that can be used in other packages
  to keep the state of a document reactive. It has <strong>no user interface</strong>.
  The package is based on <a href="https://redux.js.org/" target="_blank">Redux</a> which is compatible with many popular
  javascript frameworks (e.g. <a href="https://reactjs.org/" target="_blank">React</a>, <a href="https://vuejs.org/" target="_blank">Vue</a>, etc.).
</p>

<h2>License and Contact</h2>
<p>
  Everything is distributed under the permissive
  <a href="https://github.com/curvenote/article/blob/master/LICENSE">MIT License</a>
  to make it easy for you to use these packages with your other projects!
</p>
{% include 'content/introduction-snippet.tpl' %}
{% endblock%}

{% extends "layout/article.tpl" %}
{% block article %}
<h1>@curvenote/article</h1>
<r-outline class="popout"></r-outline>
<h2>Introduction</h2>
<p>
  The <code>@curvenote/article</code> is bundled with web-components and a CSS framework
  that helps you write interactive scientific articles.
  This documentation makes use of these components and styles.
  All components and layouts can be used by having the following structure to your HTML:
</p>

<r-code language="html" copy>
  &lt;!doctype html&gt;
  &lt;html itemscope itemtype="http://schema.org/Article"&gt;
  &lt;head&gt;
    &lt;link rel="stylesheet" href="https://unpkg.com/@curvenote/article/dist/curvenote.css"&gt;
    &lt;script async src="https://unpkg.com/@curvenote/article"&gt;&lt;/script&gt;
  &lt;/head&gt;
  &lt;body&gt;
    &lt;article&gt;
      &lt;h1&gt;Hello Curvenote&lt;/h1&gt;
    &lt;/article&gt;
  &lt;/body&gt;
</r-code>

<p>
  The javascript will load up the <a href="/components">components</a>, which allow you to add reactivity to your
  document. The CSS framework assumes there is an <code>&lt;article&gt;</code> on the page.
  To center the article, which will collapse the sidenotes (aside), you can add the <code>"centered"</code> class
  to the article.
</p>

<script>
  function toggleArticleCentered(centered) {
    Array.from(document.querySelectorAll('article, nav')).forEach(
      e=>e.classList[centered ? 'add' : 'remove']('centered')
    )
    return { centered };
  }
</script>
<r-var name="centered" value="false" type="Boolean"></r-var>
<aside class="margin">
  <r-switch :value="centered" :change="toggleArticleCentered(value)" label="Center Article"></r-switch>
</aside>

<r-code>
  &lt;article class="centered"&gt;&lt;/article&gt;
</r-code>

<h2>Layout</h2>
<div class="card-container">
  <r-card title="Aside - r-aside" description="Write in the margins" img-src="/images/article/aside.png" url="/article/aside" width="46%" contain></r-card>
  <r-card title="Callout - r-callout" description="Call things out" img-src="/images/article/callout.png" url="/article/callout" width="46%" contain></r-card>
  <r-card title="Quote - r-quote" description="Quotes are wonderful" img-src="/images/article/quote.png" url="/article/quote" width="46%" contain></r-card>
  <r-card title="Outline - r-outline" description="Make sure you know where you are" img-src="/images/article/outline.gif" url="/article/outline" width="46%" contain></r-card>
</div>

<h2>Article Components</h2>
<div class="card-container">
  <r-card title="Equation - r-equation" description="Equations are fun" img-src="/images/article/equation.png" url="/article/equation" width="46%" contain></r-card>
  <r-card title="Code - r-code" description="Equations are fun" img-src="/images/article/code.png" url="/article/code" width="46%"></r-card>
  <r-card title="Demo - r-demo" description="Equations are fun" img-src="/images/article/demo.png" url="/article/demo" width="46%" contain></r-card>
</div>


{% endblock%}

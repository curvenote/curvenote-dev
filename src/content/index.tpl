{% extends "layout/article.tpl" %}
{% block article %}
<h1>curvenote.dev</h1>
<r-outline class="popout"></r-outline>
<p>
  The goal of <code>curvenote.dev</code> is to provide open source tools to promote and enable
  interactive scientific writing, reactive documents and <a href="https://explorabl.es/" target="_blank">explorable explanations</a>.
  These tools are used and supported by <a href="{{ site.main }}">curvenote.com</a>,
  which is an interactive scientific writing platform that integrates to <a href="{{ site.main }}/for/jupyter/">Jupyter</a>.
</p>

<h2 id="for-example">But first, an example!</h2>
{% include 'content/example.tpl' %}

<hr>

<h2>Text Editor</h2>
<div class="card-container">
  <r-card title="Editor" description="Overview of WYSIWYG editor" img-src="/images/editor.gif" url="/editor" contain></r-card>
  <r-card title="Schema" description="Translate" img-src="/images/schema.gif" url="/schema" contain></r-card>
  <r-card title="Sidenotes" description="Positioning of floating comments." img-src="/images/sidenotes.gif" url="/sidenotes" contain></r-card>
</div>

<h2>Components and Documentation</h2>
<div class="card-container">
  <r-card title="Introduction" description="Learn how to get started" img-src="/images/article/callout.png" url="/introduction" contain></r-card>
  <r-card title="Components" description="Sliders, equations, charts, oh-my" img-src="/images/components/button.gif" url="/components" contain></r-card>
  <r-card title="Article" description="Equations, layout and more" img-src="/images/components/visible.gif" url="/article" contain></r-card>
  <r-card title="SVG" description="Charts and reactive SVGs" img-src="/images/svg/eqn.gif" url="/svg" contain></r-card>
  <r-card title="Runtime" description="Reactive redux runtime" img-src="/images/runtime.png" url="/runtime" contain></r-card>
  <r-card title="Showcase" description="Examples of curvenote in action" img-src="/images/showcase/unit-star.gif" url="/showcase" contain></r-card>
</div>

<hr>
{% include 'content/getting-started-snippet.tpl' %}
<hr>
{% include 'content/introduction-snippet.tpl' %}
{% endblock %}

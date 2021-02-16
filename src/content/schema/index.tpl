{% extends "layout/article.tpl" %}
{% block article %}
<h1>@curvenote/schema</h1>
<r-outline class="popout"></r-outline>
<p>Schema for interactive scientific writing, with translations to
<a href="https://myst-parser.readthedocs.io/en/latest/">MyST flavoured markdown</a>, LaTeX, and HTML.</p>

<aside class="callout">
  <p>Checkout the <a href="https://curvenote.github.io/editor/">live demo</a>!</p>
</aside>

<img src="https://raw.githubusercontent.com/curvenote/schema/main/images/schema.gif">

<h2>Overview &amp; Goals</h2>
<ul>
  <li>
    <p>Provide a typed schema for writing reactive scientific documents using <a href="https://curvenote.dev/">@curvenote/components</a></p>
    <ul>
      <li>
        <p>Uses <a href="https://developer.mozilla.org/en-US/docs/Web/Web_Components">Web Components</a> in
          the rendered HTML output for non-standard components</p>
      </li>
      <li>
        <p>Uses standard html for all other components, with no styling enforced</p>
      </li>
    </ul>
  </li>
  <li>
    <p>Interoperability with CommonMark markdown and <a
        href="https://github.com/executablebooks/markdown-it-myst">MyST</a></p>
    <ul>
      <li>
        <p>Through <code>fromMarkdown</code> and <code>toMarkdown</code> methods</p>
      </li>
    </ul>
  </li>
  <li>
    <p>Provide components for <a href="https://en.wikipedia.org/wiki/WYSIWYG">WYSIWYG</a> editing of
      reactive documents</p>
    <ul>
      <li>
        <p>See <a href="https://github.com/curvenote/editor"><code>@curvenote/editor</code></a> or <a
            href="https://github.com/curvenote/schema/blob/main/Curvenote.com">curvenote.com</a> for the editor!
        </p>
      </li>
    </ul>
  </li>
</ul>
<h2>Choices</h2>
<ul>
  <li>
    <p>The internal representation for the library is a <a
        href="https://prosemirror.net/docs/guide/#doc">ProseMirror Document</a> structure (that can be rendered
      as JSON)</p>
  </li>
  <li>
    <p><a href="https://github.com/markdown-it/markdown-it">markdown-it</a> is used parse and tokenize markdown
      content</p>
  </li>
</ul>
<h2><strong>Schema</strong></h2>
<p>The schema has <code>Nodes</code> and <code>Marks</code> where <code>Nodes</code> are
  basically a block of content (paragraph, code, etc.), and <code>Marks</code> are inline modifications to the
  content (bold, emphasis, links, etc.). See the ProseMirror docs for a <a
    href="https://prosemirror.net/docs/guide/#doc">visual explanation</a>.</p>
<p><strong>Overview of </strong><code>Nodes</code></p>
<ul>
  <li>
    <p>Basic Markdown</p>
    <ul>
      <li>
        <p>text</p>
      </li>
      <li>
        <p>paragraph</p>
      </li>
      <li>
        <p>heading</p>
      </li>
      <li>
        <p>blockquote</p>
      </li>
      <li>
        <p>code_block</p>
      </li>
      <li>
        <p>image</p>
      </li>
      <li>
        <p>horizontal_rule</p>
      </li>
      <li>
        <p>hard_break</p>
      </li>
      <li>
        <p>ordered_list</p>
      </li>
      <li>
        <p>bullet_list</p>
      </li>
      <li>
        <p>list_item</p>
      </li>
    </ul>
  </li>
  <li>
    <p>Presentational Components</p>
    <ul>
      <li>
        <p><a href="https://curvenote.dev/article/callout">callout</a></p>
      </li>
      <li>
        <p><a href="https://curvenote.dev/article/aside">aside</a></p>
      </li>
      <li>
        <p><a href="https://curvenote.dev/article/math">math</a></p>
      </li>
      <li>
        <p><a href="https://curvenote.dev/article/equation">equation</a></p>
      </li>
    </ul>
  </li>
  <li>
    <p>Reactive Components</p>
    <ul>
      <li>
        <p><a href="https://curvenote.dev/components/variable">variable</a></p>
      </li>
      <li>
        <p><a href="https://curvenote.dev/components/display">display</a></p>
      </li>
      <li>
        <p><a href="https://curvenote.dev/components/dynamic">dynamic</a></p>
      </li>
      <li>
        <p><a href="https://curvenote.dev/components/range">range</a></p>
      </li>
      <li>
        <p><a href="https://curvenote.dev/components/switch">switch</a></p>
      </li>
    </ul>
  </li>
</ul>
<p><strong>Overview of </strong><code>Marks</code></p>
<ul>
  <li>
    <p>link</p>
  </li>
  <li>
    <p>code</p>
  </li>
  <li>
    <p>em</p>
  </li>
  <li>
    <p>strong</p>
  </li>
  <li>
    <p>superscript</p>
  </li>
  <li>
    <p>subscript</p>
  </li>
  <li>
    <p>strikethrough</p>
  </li>
  <li>
    <p>underline</p>
  </li>
  <li>
    <p>abbr</p>
  </li>
</ul>
<h2><strong>Simple Example</strong></h2>
<p>This moves from markdown --&gt; JSON --&gt; HTML. The JSON is the intermediate representation
  for <code>@curvenote/editor</code>.</p>
<r-code language="javascript">import { Schema, nodes, marks, fromMarkdown, toHTML } from '@curvenote/schema';
import { JSDOM } from 'jsdom';

const schema = new Schema({ nodes, marks });

const content = '# Hello `@curvenote/schema`!';
const doc = fromMarkdown(content, schema);

console.log(doc.toJSON());
&gt;&gt; {
    "type": "doc",
    "content": [
      {
        "type": "heading",
        "attrs": { "level": 1 },
        "content": [
          { "type": "text", "text": "Hello " },
          {
            "type": "text",
            "marks": [ { "type": "code" } ],
            "text": "@curvenote/schema"
          },
          { "type": "text", "text": "!" }
        ]
      }
    ]
  }

// Assuming we are in node, just use `document` if in a browser!
const { document } = new JSDOM('').window;

// Now move the document back out to html
const html = toHTML(doc, schema, document);

console.log(html);
&gt;&gt; "&lt;h1&gt;Hello &lt;code&gt;@curvenote/schema&lt;/code&gt;!&lt;/h1&gt;"
</r-code>
<h3><strong>Roadmap</strong></h3>
<ul>
  <li>
    <p>Integrate other <code>@curvenote/components</code> as nodes</p>
  </li>
  <li>
    <p>Improve equation and start to go to/from various MyST syntax for this</p>
  </li>
  <li>
    <p>Add figure properties (name, width, caption etc.)</p>
  </li>
  <li>
    <p>Provide citations, probably bring in a bibtex parser</p>
    <ul>
      <li>
        <p>Introduce citation and reference component to curvenote/components or article</p>
      </li>
    </ul>
  </li>
  <li>
    <p>Add overlaping roles/directives with MyST (e.g. see <a
        href="https://github.com/executablebooks/meta/issues/70">executablebooks/meta#70</a>) for pointers</p>
    <ul>
      <li>
        <p>Add the necessary pieces to curvenote/components that are not basic html (MyST uses sphinx for the heavy
          lifting, cross-refs etc.)</p>
      </li>
    </ul>
  </li>
  <li>
    <p>Provide other sereializers from the document strucutre (e.g. latex or simple html without curvenote/components,
      possibly idyll)</p>
  </li>
</ul>
<h2><strong>See also:</strong></h2>
<ul>
  <li>
    <p><a href="https://idyll-lang.org/">Idyll Lang</a> has a different markdown-like serialization with very
      similar base components to curvenote - see <a
        href="https://github.com/curvenote/article/issues/8">curvenote/article#8</a> for a comparison.</p>
  </li>
</ul>
{% endblock%}

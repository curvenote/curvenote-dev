{% extends "layout/article.tpl" %}
{% block article %}
<h1>@curvenote/sidenotes</h1>
<r-outline class="popout"></r-outline>
<p>Position floating sidenotes/comments next to a document with inline references.</p>
<h2>Goals</h2>
<ul>
  <li>
    <p>Place notes/comments to the side of one or more documents with inline references.</p>
  </li>
  <li>
    <p>When an inline reference is clicked, animate the relevant sidenote to be as close as possible and move
      non-relevant sidenotes out of the way without overlapping.</p>
  </li>
  <li>
    <p>Do not provide UI or impose any styling,&nbsp;<strong>only placement</strong>.</p>
  </li>
</ul>
<h2>Use Cases</h2>
<ul>
  <li>
    <p>Comment streams next to a document. This is showing&nbsp;<a href="https://curvenote.com/">Curvenote</a>, which
      is a scientific writing platform that connects to Jupyter.&nbsp;</p>
      <img src="https://github.com/curvenote/sidenotes/raw/main/images/comments.gif" alt="Comments Using Sidenotes">
  </li>
</ul>
<h2>Choices</h2>
<ul>
  <li>
    <p>Use React, Redux &amp; Typescript</p>
  </li>
  <li>
    <p>Used Redux rather than a hook approach (open to discussion if people are passionate!)</p>
  </li>
</ul>
<h2>Constraints</h2>
<ul>
  <li>
    <p>Multiple documents on the page, currently based on the wrapping&nbsp;<code>&lt;article&gt;</code>&nbsp;ID</p>
  </li>
  <li>
    <p>Multiple inline references per sidenote, wrapped
      in&nbsp;<code>&lt;InlineAnchor&gt;</code>;&nbsp;<code>InlineAnchor</code>&nbsp;is a&nbsp;<code>span</code></p>
  </li>
  <li>
    <p>Have fallback placements to a&nbsp;<code>&lt;AnchorBase&gt;</code>;&nbsp;<code>AnchorBase</code>&nbsp;is
      a&nbsp;<code>div</code></p>
  </li>
  <li>
    <p>Provide actions to attach non-react bases, anchors or reposition sidenotes</p>
  </li>
  <li>
    <p>All positioning is based on the article, and works
      with&nbsp;<code>relative</code>,&nbsp;<code>fixed</code>&nbsp;or&nbsp;<code>absolute</code>&nbsp;positioning.</p>
  </li>
</ul>
<h2>Demo</h2>
<p>The demo is pretty basic, and not nearly as pretty as the gif above, just blue, green and red divs floating around.
  See&nbsp;<a href="https://github.com/curvenote/sidenotes/blob/main/demo/index.tsx">index.tsx</a>&nbsp;for full the
  code/setup.</p>
<r-code>
  yarn install
  yarn start
</r-code>
<img src="https://github.com/curvenote/sidenotes/raw/main/images/sidenotes.gif" alt="Sidenotes">
<h2>Getting Started:</h2>
<r-code>yarn add sidenotes</r-code>
<h2>React Setup:</h2>
<r-code>&lt;article id={docId} onClick={deselect}&gt;
  &lt;AnchorBase anchor={baseId}&gt;
    Content with &lt;InlineAnchor sidenote={sidenoteId}&gt;inline reference&lt;/InlineAnchor&gt;
  &lt;/AnchorBase&gt;
  &lt;div className="sidenotes"&gt;
    &lt;Sidenote sidenote={sidenoteId} base={baseId}&gt;
      Your custom UI, e.g. a comment
    &lt;/Sidenote&gt;
  &lt;/div&gt;
&lt;/article&gt;</r-code>
<p>The&nbsp;<code>sidenotes</code>&nbsp;class is the only CSS that is recommended. You can import it directly,
  or&nbsp;<a href="https://github.com/curvenote/sidenotes/blob/main/styles/index.scss">look at it</a>&nbsp;and change
  it (~30 lines of&nbsp;<code>scss</code>). To import from javascript (assuming your bundler works with CSS):</p>
<r-code>import 'sidenotes/dist/sidenotes.css';</r-code>
<h2>Redux State</h2>
<p>Once you create your own store, add a&nbsp;<code>sidenotes.reducer</code>, it must be
  called&nbsp;<code>sidenotes</code>. Then pass the&nbsp;<code>store</code>&nbsp;to&nbsp;<code>setup</code>&nbsp;with
  options of padding between sidenotes.</p>
<r-code>import { combineReducers, applyMiddleware, createStore } from 'redux';
import thunkMiddleware from 'redux-thunk';
import * as sidenotes from 'sidenotes';

const reducer = combineReducers({
  yourStuff: yourReducers,
  sidenotes: sidenotes.reducer, // Add this to your reducers
});
// Create your store as normal, must have thunkMiddleware
const store = createStore(reducer, applyMiddleware(thunkMiddleware));

// Then ensure that you pass the `store` to setup the sidenotes
sidenotes.setup(store as sidenotes.Store, { padding: 10 })</r-code>
<h2>Redux State</h2>
<p>The&nbsp;<code>sidenotes.ui</code>&nbsp;state has the following structure:</p>
<r-code>sidenotes:
  ui:
    docs:
      [docId]:
        anchors:
          [anchorId]: { id: string, sidenote: string, element: [span] }
        sidenotes:
          [sidenoteId]: { inlineAnchors: string[], top: number, id: string, baseAnchors: string[] }
        id: string
        selectedAnchor: string
        selectedNote: string
</r-code>
<h2>Roadmap</h2>
<ul>
  <li>
    <p>Have a better mobile solution that places notes at the bottom.</p>
  </li>
</ul>
{% endblock%}

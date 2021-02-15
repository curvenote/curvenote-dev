
<a href="https://jsbin.com/qulahusifa/5/edit?html,output" target="_blank" style="float:right;text-decoration: none;"><r-button outlined dense label="Edit Now"></r-button></a>
<h1>Getting Started</h1>

<p>The easiest way to get started is to put the Javascript bundle and the stylesheet directly to your page:</p>
<r-code compact copy>
  &lt;link rel="stylesheet" href="https://unpkg.com/@curvenote/article/dist/curvenote.css"&gt;
  &lt;script src="https://unpkg.com/@curvenote/article"&gt;&lt;/script&gt;
</r-code>

<aside class="callout success">
<p>Try editing an <a href="https://jsbin.com/qulahusifa/5/edit?html,output" target="_blank">article on jsbin</a> without leaving your browser!</p>
</aside>

<p>
  You can also download the <a href="https://github.com/curvenote/article/releases" target="_blank">latest release</a> from GitHub.
  If you are running this <em>without</em> a web server, ensure the script has <code>charset="utf-8"</code> in
  the script tag.
  You can also install from npm:
</p>
<r-code compact copy language="bash">
  npm install @curvenote/article @curvenote/components @curvenote/svg @curvenote/runtime
</r-code>

<p>You should then be able to extend the package as you see fit:</p>
<r-code compact copy language="javascript">
  import components from '@curvenote/article';
</r-code>

<p>
  See <a href="https://github.com/curvenote" target="_blank">Curvenote on GitHub</a> for more information about the libraries.
</p>


<h1>Getting Started</h1>

<p>The easiest way to get started is to put the javascript bundle directly to your page:</p>
<r-code compact copy>
  &lt;link rel="stylesheet" href="https://unpkg.com/@iooxa/article/dist/iooxa.css"&gt;
  &lt;script async src="https://unpkg.com/@iooxa/article"&gt;&lt;/script&gt;
</r-code>
<p>
  You can also download the <a href="https://github.com/iooxa/article/releases"
    target="_blank">latest release</a> from GitHub.
  If you are running this <em>without</em> a web server, ensure the script has <code>charset="utf-8"</code> in
  the script tag.
  You can also install from npm:
</p>
<r-code compact copy language="bash">
  npm install @iooxa/article
</r-code>

<p>You should then be able to extend ink as you see fit:</p>
<r-code compact copy language="javascript">
  import components from '@iooxa/article';
</r-code>

{% if links.prev %}
<a href="{{ links.prev.url }}" style="text-decoration: none; float: left;">
  <r-button outlined label="< {{ links.prev.label }}"></r-button>
</a>
{% endif %}
{% if links.next %}
<a href="{{ links.next.url }}" style="text-decoration: none; float: right;">
  <r-button outlined label="{{ links.next.label }} >"></r-button>
</a>
{% endif %}
<p style="clear:both; text-align: center; color: #AAA; padding-top: 50px;">Made with love by <a href="https://iooxa.com" style="color: #AAA;"><img src="/images/icon.png" style="height: 1em;"> iooxa</a></p>

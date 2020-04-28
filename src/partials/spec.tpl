{% if spec.properties.length > 0 %}
<h2>Properties</h2>
<aside class="callout">
  <dl>
{% for prop in spec.properties %}
    <dt>{{prop.name}} <code>{{prop.type}}</code></dt><dd>{{ prop.description }}, Default: {{ prop.default }}</dd>
{% endfor %}
  </dl>
</aside>
{% endif %}
{% if spec.events.length > 0 %}
<h2>Events</h2>
<aside class="callout">
  <dl>
{% for evt in spec.events %}
    <dt><code>{{evt.name}}</code></dt><dd>{{ evt.description }}, Arguments: {{ evt.args.join(", ") }}</dd>
{% endfor %}
  </dl>
</aside>
{% endif %}

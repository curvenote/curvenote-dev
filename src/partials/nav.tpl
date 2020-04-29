<nav class="popout{{ ' centered' | safe if page.centered }}">
  <div>{{ nav.label }}</div>
  <ul>
{% for item in nav.children %}
{% if item.type == 'section' %}
    <li class="section{{ ' open selected' if item.open }}">
      <div>{{ item.label }}</div>
      <ul>
{% for subitem in item.children %}
{% if subitem.selected %}
        <li><a class="selected">{{ subitem.label}}</a></li>
{% else %}
        <li><a href="{{ subitem.url }}">{{ subitem.label}}</a></li>
{% endif %}
{% endfor %}
      </ul>
    </li>
{% else %}
{% if item.selected %}
    <li><a class="selected">{{ item.label}}</a></li>
{% else %}
    <li><a href="{{ item.url }}">{{ item.label}}</a></li>
{% endif %}
{% endif %}
{% endfor %}
  </ul>
</nav>

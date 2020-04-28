{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
{% include 'partials/logo.tpl' %}
<h1>Visual Overview of Components</h1>
<r-outline class="popout"></r-outline>
<h2>Basic Components</h2>
<r-card title="Variable - r-var" description="Reactive variables" img-src="/images/components/var.png" url="/components/variable" width="46%" contain></r-card>
<r-card title="Display - r-display" description="Display inline text" img-src="/images/components/display.gif" url="/components/display" width="46%" contain></r-card>
<r-card title="Dynamic Text - r-dynamic" description="Dynamic text" img-src="/images/components/dynamic.gif" url="/components/dynamic" width="46%" contain></r-card>
<r-card title="Conditional Visiblity - r-visible" description="Show or hide components" img-src="/images/components/visible.gif" url="/components/visible" width="46%" contain></r-card>

<h2>Reactive Material Components</h2>
<r-card title="Range - r-range" description="A slider is a burger" img-src="/images/components/range.gif" url="/components/range" width="46%" contain></r-card>
<r-card title="Action - r-action" description="Inline text for clicking" img-src="/images/components/action.gif" url="/components/range" width="46%" contain></r-card>
<r-card title="Button - r-button" description="Material buttons" img-src="/images/components/button.gif" url="/components/button" width="46%" contain></r-card>
<r-card title="Switch - r-switch" description="Material switchs" img-src="/images/components/switch.gif" url="/components/switch" width="46%" contain></r-card>
<r-card title="Checkbox - r-checkbox" description="Material checkbox" img-src="/images/components/checkbox.gif" url="/components/checkbox" width="46%" contain></r-card>
<r-card title="Radio - r-radio" description="Material radio" img-src="/images/components/radio.gif" url="/components/radio" width="46%" contain></r-card>
<r-card title="Select - r-select" description="Material select" img-src="/images/components/select.gif" url="/components/select" width="46%" contain></r-card>
<r-card title="Input - r-input" description="Material input" img-src="/images/components/input.gif" url="/components/input" width="46%" contain></r-card>

{% endblock%}

{% extends "layout/article.tpl" %}
{% block preArticle %}
{% include 'partials/nav.tpl' %}
{% endblock %}
{% block article %}
<h1>Taylor Series</h1>
<p>
The Taylor series of a real or complex-valued function $f(x)$ that is infinitely differentiable at a real or complex number $a$ is the power series
<r-equation>
    f(x) \approx f(a) + \frac {f'(a)}{1!} (x-a) + \frac{f''(a)}{2!} (x-a)^2 + \frac{f^{(3)}(a)}{3!}(x-a)^3 + \cdots
</r-equation>
where $n!$ denotes the factorial of $n$ and $f^{(n)}(a)$ denotes the $n$th derivative of $f$ evaluated at the point $a$. In the more compact sigma notation, this can be written as
<r-equation>
    \sum _{n=0}^{\infty }{\frac {f^{(n)}(a)}{n!}}(x-a)^{n}.
</r-equation>
The derivative of order zero of $f$ is defined to be $f$ itself and $(x - a)^0$ and $0!$ are both defined to be 1. When $a = 0$, the series is also called a Maclaurin series.
</p>

<r-var name="ind" value="1"></r-var>
<r-var name="katex" value='["\\sin(x) \\approx x", "-{\\frac {x^{3}}{3!}}", "+{\\frac {x^{5}}{5!}}", "-{\\frac {x^{7}}{7!}}", "-{\\frac {x^{9}}{9!}}", "+{\\frac {x^{11}}{11!}}", "-{\\frac {x^{13}}{13!}}", "-{\\frac {x^{15}}{15!}}"]' type="Array"></r-var>
<r-var name="eqn" value='["x", "- (Math.pow(x, 3) / 6)", "+ (Math.pow(x, 5) / 120)", "- (Math.pow(x, 7) / 5040)", "+ (Math.pow(x, 9) / 362880)", "- (Math.pow(x, 11) / 39916800)", "+ (Math.pow(x, 13) / 6227020800)", "- (Math.pow(x, 15) / 1307674368000)"]' type="Array"></r-var>

<p>
    The sine function is closely approximated by its Taylor polynomial of <r-action :click="{ind: 4}">degree 7</r-action> for a full period centered at the origin.<br>
    Try expanding the Taylor series: <r-range bind="ind" min="1" max="8"></r-range>.
    <r-equation :math="katex.slice(0, ind).join(' ') + ' + \\cdots'"></r-equation>
</p>

<r-svg-chart :xlim="[-3 * Math.PI, 3 * Math.PI]" ylim="[-3, 3]">
    <r-svg-eqn eqn="Math.sin(x)"></r-svg-eqn>
    <r-svg-eqn :eqn="eqn.slice(0, 1).join(' ')" stroke="#333" stroke-width="1" stroke-dasharray="1 5"></r-svg-eqn>
    <r-svg-eqn :eqn="eqn.slice(0, 2).join(' ')" stroke="#333" stroke-width="1" stroke-dasharray="1 5"></r-svg-eqn>
    <r-svg-eqn :eqn="eqn.slice(0, 3).join(' ')" stroke="#333" stroke-width="1" stroke-dasharray="1 5"></r-svg-eqn>
    <r-svg-eqn :eqn="eqn.slice(0, 4).join(' ')" stroke="#333" stroke-width="1" stroke-dasharray="1 5"></r-svg-eqn>
    <r-svg-eqn :eqn="eqn.slice(0, 5).join(' ')" stroke="#333" stroke-width="1" stroke-dasharray="1 5"></r-svg-eqn>
    <r-svg-eqn :eqn="eqn.slice(0, 6).join(' ')" stroke="#333" stroke-width="1" stroke-dasharray="1 5"></r-svg-eqn>
    <r-svg-eqn :eqn="eqn.slice(0, 7).join(' ')" stroke="#333" stroke-width="1" stroke-dasharray="1 5"></r-svg-eqn>
    <r-svg-eqn :eqn="eqn.slice(0, 8).join(' ')" stroke="#333" stroke-width="1" stroke-dasharray="1 5"></r-svg-eqn>
    <r-svg-eqn :eqn="eqn.slice(0, ind).join(' ')" stroke-width="2" stroke="green"></r-svg-eqn>
</r-svg-chart>

{% endblock%}

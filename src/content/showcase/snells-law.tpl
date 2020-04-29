{% extends "layout/article.tpl" %}
{% block article %}
<h1>Snell's Law</h1>
<h2>Angles Of Reflection And Refraction</h2>
<r-scope name="snells">
<p>
  Consider a P-wave which is incident at an angle $\theta_1$ measured with respect to the normal of the interface, as seen in the figure below where the approaching wave is represented as a ray.
  The angles of the reflected and refracted rays are as follows:
</p>
<aside class="callout">
  <strong>Law of Reflection:</strong> The angle of reflection equals the angle of incidence. So $\theta_r = \theta_1$.
</aside>
<aside class="callout">
  <strong>Law of Refraction:</strong> The angle of refraction $\theta_2$ is determined through Snell's Law:
  <r-equation>
    \frac{\sin \theta_1}{v_1} = \frac{\sin \theta_2}{v_2}
  </r-equation>
</aside>
<p>
  If the wave travels from a low velocity medium to a high velocity medium the wave gets refracted away from the normal.
  Conversely, it gets refracted toward the normal if the wave goes from a high velocity to a low velocity medium.
</p>
<r-var name="thetaIn" value="0.7853981633974483"></r-var>
<r-var name="theta1" :value="Math.min(Math.max(0, thetaIn), Math.PI/2)"></r-var>
<r-var name="v1" value="400"></r-var>
<r-var name="v2" value="500"></r-var>
<r-var name="theta2" :value="Math.asin(v2 * Math.sin(theta1) / v1)"></r-var>
<r-var name="thetac" :value="Math.asin(v1 / v2)"></r-var>

<br>
<p>
  $\theta_1$: <r-dynamic :value="theta1 * 180 / Math.PI" :change="{thetaIn: value * Math.PI / 180}" min="0" max="90">&deg;</r-dynamic><br>
  $\theta_2$: <r-visible :visible="!isFinite(theta2)">No Refraction Wave</r-visible><r-visible :visible="isFinite(theta2)"><r-display bind="theta2" :transform="value*180/Math.PI"></r-display>&deg;</r-visible><br>
  $v_1$: <r-range bind="v1" min="100" :max="v2" step="10"></r-range><r-display bind="v1"></r-display>m/s<br>
  $v_2$: <r-range bind="v2" :min="v1" max="2000" step="10"></r-range><r-display bind="v2"></r-display>m/s<br>
</p>

<r-svg-chart xlim="[-1.1,1.1]" ylim="[-1.1,1.1]" width="400" height="400" x-axis-location="hidden" y-axis-location="hidden" style="text-align: center;">
  <r-svg-path data="[[-1, 0], [1, 0]]" stroke="black"></r-svg-path>
  <r-svg-path data="[[0, -1], [0, 1]]" stroke="black" stroke-dasharray="3 3"></r-svg-path>
  <r-svg-text x="-0.8" y="0.15" text="v1"></r-svg-text>
  <r-svg-text x="-0.8" y="-0.2" text="v2 > v1"></r-svg-text>
  <r-svg-text :x="0.5" :y="-0.2" text="No Refraction Wave" :visible="!isFinite(theta2)" text-anchor="middle"></r-svg-text>

  <r-svg-text :x="-0.9*Math.sin(theta1) - 0.1" :y="0.9*Math.cos(theta1) - 0.1" :rotate="90-theta1*180/Math.PI" text="incident -->"></r-svg-text>
  <r-svg-text :x="0.5*Math.sin(theta1) + 0.1" :y="0.5*Math.cos(theta1) - 0.1" :rotate="-90+theta1*180/Math.PI" text="reflected -->"></r-svg-text>

  <r-svg-text :x="0.5*Math.sin(theta2 + 0.1)" :y="-0.5*Math.cos(theta2 + 0.1)" :rotate="90-theta2*180/Math.PI" text="refracted -->" :visible="isFinite(theta2)"></r-svg-text>

  <r-svg-text :x="-0.35*Math.sin(theta1/2)" :y="0.35*Math.cos(theta1/2)" :text="Math.abs(theta1-thetac) * 180 / Math.PI < 0.1 ? '&theta;c' : '&theta;1'" :visible="theta1 *180 / Math.PI > 25" text-anchor="end"></r-svg-text>
  <r-svg-text :x="0.35*Math.sin(theta1/2)" :y="0.35*Math.cos(theta1/2)" text="&theta;r" :visible="theta1 *180 / Math.PI > 25"></r-svg-text>
  <r-svg-text :x="0.4*Math.sin(theta2/2)" :y="-0.4*Math.cos(theta2/2)" :text="theta2 * 180 / Math.PI > 89 ? '90&deg;' : '&theta;2'" :visible="isFinite(theta2) && theta2 *180 / Math.PI > 25" text-anchor="middle"></r-svg-text>

  <r-svg-path :data="[[0,0], [-Math.sin(theta1), Math.cos(theta1)]]" stroke="red"></r-svg-path>
  <r-svg-path :data="[[0,0], [Math.sin(theta1), Math.cos(theta1)]]" stroke="black"></r-svg-path>
  <r-svg-path :data="[[0,0], [Math.sin(theta2), -Math.cos(theta2)]]" stroke="blue" :visible="isFinite(theta2)"></r-svg-path>

  <r-svg-circle :x="-Math.sin(thetac)" :y="Math.cos(thetac)" fill="blue"></r-svg-circle>

  <r-svg-eqn :domain="[-theta1, theta1]" eqn="[-0.3*Math.sin(t), 0.3*Math.cos(t)]" parameterize="t" stroke="#333" stroke-width="1" stroke-dasharray="3"></r-svg-eqn>
  <r-svg-eqn :domain="[0, theta2]" eqn="[0.3*Math.sin(t), -0.3*Math.cos(t)]" parameterize="t" stroke="#333" stroke-width="1" stroke-dasharray="3" :visible="isFinite(theta2)"></r-svg-eqn>

  <r-svg-node r="10" fill="#ccc" :x="-Math.sin(theta1)" :y="Math.cos(theta1)" :drag="x < 0 && y > 0 ? {thetaIn: Math.atan(-x/y)} : x > 0 ? {thetaIn: 0} : {thetaIn: Math.PI/2}"></r-svg-node>
</r-svg-chart>

<p style="text-align:center; font-size: 0.8em;color:#aaa">
  Snell's Law for two layers where $v_1$= <r-display bind="v1"></r-display> m/s and $v_2$= <r-display bind="v2"></r-display> m/s.
  The incident angle of the incoming wave is $\theta_1$= <r-display bind="theta1" :transform="value*180/Math.PI"></r-display>&deg;.
  <r-span :visible="!isFinite(theta2)">When an incident wave has an angle over the critical angle, $\theta_c$, there is no refracted wave.</r-span>
</p>
<p>
  The critical refraction angle, called $\theta_c$, is a key concept in refraction seismology.
  This is the angle of incidence for which the corresponding angle of <r-action :click="{thetaIn: thetac}">refraction is 90&deg;</r-action>.
  In this case, the refracted ray travels horizontally along the interface.
  A formula for the critical angle can be derived from Snell's law as follows:
</p>
<r-equation>
  \frac{\sin \theta_c}{v_1} = \frac{\sin 90^{\circ}}{v_2} = \frac{1}{v_2}
</r-equation>
</r-scope>
{% endblock%}

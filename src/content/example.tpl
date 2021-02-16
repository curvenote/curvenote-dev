<r-scope name="sincos">
  <r-var name="r" value="0.35"></r-var>
  <r-var name="theta" value="0" format=".1f"></r-var>
  <r-var name="xC" :value="Math.cos(theta)*r-0.5"></r-var>
  <r-var name="yC" :value="Math.sin(theta)*r+0.5"></r-var>
  <r-var name="sOrigin" value="false" type="Boolean"></r-var>
  <r-var name="sRadius" value="false" type="Boolean"></r-var>
  <r-var name="sAngle" value="false" type="Boolean"></r-var>
  <r-var name="wR" value="1"></r-var>
  <r-var name="wG" value="3"></r-var>
  <r-var name="wB" value="1"></r-var>
  <r-var name="wSin" value="3"></r-var>
  <r-var name="wCos" value="3"></r-var>
  <aside class="margin">
    <p>
      To interact with this explanation, you can hover over the bolded text, or drag the node in the chart, or update $\theta$:
      <br>
      $\theta=$ <r-range :value="theta *180 / Math.PI" :change="{theta: value * Math.PI / 180}" min="0" max="360" ></r-range>
      <r-dynamic bind="theta" min="0" step="0.01" :max="Math.PI*2" periodic="true" :transform="value*180/Math.PI" after="º"></r-dynamic>
    </p>
  </aside>
  <p>
    In trigonometry, a
    <r-action :hover="{wG:enter?8:3}"><strong style="color:green">unit circle</strong></r-action>
    is the circle of
    <r-action :hover="{sRadius:enter}"><strong style="color:#333">radius</strong></r-action>
    one centered at the <r-action :hover="{sOrigin:enter}"><strong style="color:#333">origin</strong></r-action>
    $(0, 0)$ in the Cartesian coordinate system. Let a
    <r-action :hover="{sRadius:enter}"><strong style="color:#333">line</strong></r-action>
    through the
    <r-action :hover="{sOrigin:enter}"><strong style="color:#333">origin</strong></r-action>,
    making an
    <r-action :hover="{sAngle:enter}"><strong style="color:#333">angle</strong></r-action>,
    of $\theta$=
    <r-dynamic bind="theta" min="0" step="0.01" :max="Math.PI*2" periodic="true" :transform="value*180/Math.PI" after="º"></r-dynamic>
    with the positive half of the x-axis, intersect the
    <r-action :hover="{wG:enter?8:3}"><strong style="color:green">unit circle</strong></r-action>.
    The
    <r-action :hover="{wB:enter?3:1}"><strong style="color:blue">x-coordinates</strong></r-action>
    and
    <r-action :hover="{wR:enter?3:1}"><strong style="color:red">y-coordinates</strong></r-action>
    of this point of intersection are equal to
    <r-action :hover="{wCos:enter?8:3}"><strong style="color:blue">$\cos(\theta)$</strong></r-action>
    and
    <r-action :hover="{wSin:enter?8:3}"><strong style="color:red">$\sin(\theta)$</strong></r-action>,
    respectively.
    <a href="https://en.wikipedia.org/wiki/Sine#Unit_circle_definition" target="_blank">See Wikipedia</a>.
  </p>
  <r-svg-chart xlim="[-1, 2]" ylim="[-1, 1]" height="400" width="600" x-axis-location="hidden"
    y-axis-location="hidden">
    <!-- Create Axis -->
    <r-svg-path :data="[[-1,0],[2, 0],[],[0, -1], [0, 1]]" stroke="#ddd" stroke-width="2"></r-svg-path>
    <r-svg-path :data="[[-1, 0.5-r],[2, 0.5-r],[],[-1, 0.5], [2, 0.5],[],[-1, 0.5+r],[2, 0.5+r]]" stroke="#ddd"
      stroke-width="0.5"></r-svg-path>
    <r-svg-path :data="[[ 0,-0.5-r],[2,-0.5-r],[],[ 0,-0.5], [2,-0.5],[],[ 0,-0.5+r],[2,-0.5+r]]" stroke="#ddd"
      stroke-width="0.5"></r-svg-path>
    <r-svg-path :data="[[-0.5-r,1],[-0.5-r,0],[],[-0.5,1], [-0.5,0],[],[-0.5+r,1],[-0.5+r,0]]" stroke="#ddd"
      stroke-width="0.5"></r-svg-path>
    <!-- Three equations for the bottom-left curve -->
    <r-svg-eqn eqn="[-Math.cos(t)*(-0.5-r), -Math.sin(t)*(-0.5-r)]" parameterize="t" :domain="[Math.PI, Math.PI*1.5]"
      stroke="#ddd" stroke-width="0.5"></r-svg-eqn>
    <r-svg-eqn eqn="[-Math.cos(t)/-2, -Math.sin(t)/-2]" parameterize="t" :domain="[Math.PI, Math.PI*1.5]"
      stroke="#ddd" stroke-width="0.5"></r-svg-eqn>
    <r-svg-eqn eqn="[-Math.cos(t)*(-0.5+r), -Math.sin(t)*(-0.5+r)]" parameterize="t" :domain="[Math.PI, Math.PI*1.5]"
      stroke="#ddd" stroke-width="0.5"></r-svg-eqn>
    <!-- Guidelines from the current point (xC,yC) -->
    <r-svg-path :data="[[xC, yC], [0, yC]]" stroke="red" :stroke-width="wR"></r-svg-path>
    <r-svg-path :data="[[xC, yC], [xC, 0]]" stroke="blue" :stroke-width="wB"></r-svg-path>
    <r-svg-eqn eqn="[-Math.cos(t)*xC, -Math.sin(t)*xC]" parameterize="t" :domain="[Math.PI, Math.PI*1.5]"
      stroke="blue" :stroke-width="wB"></r-svg-eqn>
    <!-- Text labels -->
    <r-svg-text text="sin(&theta;)" x="1.6" :y=" 0.43-r" fill="red"></r-svg-text>
    <r-svg-text text="cos(&theta;)" x="1.6" :y="-0.57-r" fill="blue"></r-svg-text>
    <!-- Origin, radius and angle: default is hidden -->
    <r-svg-circle x="-0.5" y="0.5" :visible="sOrigin" fill="#333"></r-svg-circle>
    <r-svg-path :data="[[-0.5, 0.5], [xC,yC]]" :visible="sRadius" stroke="#333" stroke-width="3"></r-svg-path>
    <r-svg-eqn eqn="[Math.cos(t)*0.1 - 0.5, Math.sin(t)*0.1 + 0.5]" parameterize="t" :domain="[0, theta]"
      :visible="sAngle" stroke="#333" stroke-width="3"></r-svg-eqn>
    <r-svg-path :data="[[xC,yC], [-0.5, 0.5], [-0.5 + r,0.5]]" :visible="sAngle" stroke="#333" stroke-width="2">
    </r-svg-path>
    <!-- A circle! -->
    <r-svg-eqn eqn="[Math.cos(t)*r-0.5, Math.sin(t)*r+0.5]" parameterize="t" :domain="[0, Math.PI*2]" stroke="green"
      :stroke-width="wG"></r-svg-eqn>
    <!-- Offset sin and cos waves -->
    <r-svg-eqn eqn="Math.sin(x* Math.PI+theta)*r + 0.5" domain="[0, 2]" stroke="red" :stroke-width="wSin"></r-svg-eqn>
    <r-svg-eqn eqn="Math.cos(x* Math.PI+theta)*r - 0.5" domain="[0, 2]" stroke="blue" :stroke-width="wCos">
    </r-svg-eqn>
    <!-- A drag node to change the offset -->
    <r-svg-node :x="xC" :y="yC" fill="#333" :drag="{theta: (Math.PI * 2 + Math.atan2(y-0.5, x+0.5)) % (Math.PI * 2)}">
    </r-svg-node>
  </r-svg-chart>
</r-scope>

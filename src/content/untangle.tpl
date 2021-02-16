<r-scope name="untangle">
  <r-var name="simple" value="true" type="Boolean"></r-var>
  <p>
    Our work is inspired by <a href="http://worrydream.com/Tangle/guide.html" target="_blank">tangle.js</a>
    and <a href="https://explorabl.es/" target="_blank">explorable explanations</a>.
    <code>@curvenote/article</code> exposes reactive web-components so you can declaratively write
    your variables and how to display them in <code>html</code> markup.
    To get an idea of what that looks like, let's take the canonical example of <em>Tangled Cookies</em> - a simple
    reactive document to encourage you to not eat more than
    <r-action :click="{'demo1.cookies':42, 'demo2.cookies':42, simple:false}">42 cookies</r-action> in one day.
    <br>
    <em>Try dragging
      <r-dynamic :value="$variables[simple?'demo1':'demo2'].cookies" :change="{'demo1.cookies':value, 'demo2.cookies':value}" min="2" max="100" after=" cookies" format=".4"></r-dynamic>
      to the left or right!
    </em>
  </p>
  <r-button :click="{simple: !simple}" :label="`${(simple ? 'Show' : 'Hide')} Advanced Example`"
    style="float: right;"></r-button>
  <r-visible :visible="simple">
    <r-scope name="demo1">
      <r-demo>
        <r-var name="cookies" value="3" format=".4"></r-var>
        <p>
          When you eat <r-dynamic bind="cookies" min="2" max="100" after=" cookies"></r-dynamic>,
          you consume <r-display :value="cookies * 50" format=".0f" /></r-display> calories.
        </p>
      </r-demo>
    </r-scope>
  </r-visible>

  <r-visible :visible="!simple">
    <r-scope name="demo2">
      <r-demo>
        <r-var name="cookies" value="3" format=".4"></r-var>
        <r-var name="caloriesPerCookie" value="50"></r-var>
        <r-var name="dailyCalories" value="2100"></r-var>

        <r-var name="calories" :value="cookies * caloriesPerCookie" format=".0f"></r-var>
        <r-var name="dailyPercent" :value="calories / dailyCalories" format=".0%"></r-var>

        <p>
          When you eat <r-dynamic bind="cookies" min="2" max="100" after=" cookies"></r-dynamic>,
          you consume <r-display bind="calories"></r-display> calories.<br>
          That's <r-display bind="dailyPercent"></r-display> of your recommended daily calories.
        </p>
      </r-demo>
    </r-scope>
  </r-visible>
</r-scope>

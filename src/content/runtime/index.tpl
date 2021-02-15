{% extends "layout/article.tpl" %}
{% block article %}
<h1>@curvenote/runtime</h1>
<r-outline class="popout"></r-outline>
<p>
  The <code>runtime</code> package allows you to create variables and components that react to changes in state through
  <strong>user-defined</strong> functions. The runtime is a small component that can be used in other packages to keep
  the state of a document reactive. The package is based on <a href="https://redux.js.org/">Redux</a> which is
  compatible with many popular javascript frameworks (e.g. <a href="https://reactjs.org/">React</a>, <a
    href="https://vuejs.org/">Vue</a>, etc.).
</p>
<h2>Getting Started</h2>
<p>This package is not setup directly for use in a browser, please see the <a href="/components">@curvenote/components</a> package to see it in use. For use in
  other packages, node, etc. you can download the
  <a href="https://www.npmjs.com/package/@curvenote/runtime">latest release from npm</a>:
</p>
<r-code language="bash">
  &gt;&gt; npm install @curvenote/runtime
</r-code>
<p>You should then be able to extend/integrate the <code>runtime</code> as you see fit:</p>
<r-code language="javascript">
  import { createStore, applyMiddleware, combineReducers } from 'redux';
  import thunkMiddleware from 'redux-thunk';
  import runtime, { actions, reducer } from '@curvenote/runtime';

  // Create a store
  const store = createStore(
    combineReducers({ runtime: reducer }),
    applyMiddleware(
    thunkMiddleware,
    runtime.triggerEvaluate,
    runtime.dangerousEvaluatation,
    ),
  );
</r-code>
<p>
  For more information on <a href="https://redux.js.org/">Redux</a> or
  <a href="https://redux.js.org/advanced/async-actions">Redux Thunk</a>,
  please see their docs and tutorials.
</p>
<h2>State Structure</h2>
<p>The basic state structure is:</p>
<r-code language="json">
  {
    "runtime": {
      "specs": {…},
      "variables": {…},
      "components": {…}
    }
  }
</r-code>
<p>Each of the sub-states, <code>{…}</code>, is a dictionary with <code>uuid</code> keys, to an object that represents a
  <code>variable</code> or a <code>component</code>.</p>
<ul>
  <li>
    <p><strong>specs</strong>: the definition of components, including properties and events. The variable spec is the
      only component spec included by default.</p>
  </li>
  <li>
    <p><strong>variables</strong>: holds the state of named values (e.g. numbers, strings, etc.), they cannot have
      events (other than changing the value of the variable)</p>
  </li>
  <li>
    <p><strong>components</strong>: an object that holds the state of a component (e.g. a slider, equation, etc. or more
      complicated widget). Components have properties that can be defined as functions, as well as named events (e.g.
      click, change, etc.) that are defined within the spec.</p>
  </li>
</ul>
<p>The state <strong>must</strong> be composed inside of an <code>runtime</code> dictionary. This allows you to compose
  the runtime state inside of your larger application, if required.</p>
<h2>Variables</h2>
<p>Variables have a <code>name</code> and a <code>value</code> and they can also be defined by a function
  (<code>func</code>). Depending on if a function is provided the variable will be <code>derived</code>, meaning that
  the function is used to evaluate the variable and provide the <code>current</code> value.</p>
<p>All components and variables also have a <code>scope</code> which is used to provide the variables by name when they
  are evaluated.</p>
<p>To create a variable, create a store and dispatch the createVariable action:</p>
<r-code language="javascript">
  const x = store.dispatch(actions.createVariable('myScope.x', null, '1 + 1'));
  const y = store.dispatch(actions.createVariable('myScope.y', 1));
</r-code>
<p>The name must be a simple variable name, with an optional <code>scope</code> prepending the name, the default scope
  is "global". The value in this case of <code>x</code> is null and a function is provided as (<code>'1 + 1'</code>)
  which will be evaluated by the middleware in the <code>store</code>.</p>
<aside class="callout danger">
  <p>
    <strong>Note:</strong> The functions provided are strings and their evaluation can be <strong>dangerous</strong> if
    you do not trust the source. Read more on the dangers on
    <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/eval">MDN</a>,
    the runtime package uses a <code>Function</code> constructor not <code>eval</code>.
  </p>
</aside>
<h3>Get and Set Variable Properties</h3>
<p>The dispatched action returns a shortcut that can be used to decrease the verbosity of further changes to the
  variable properties. Note that the current state and the <code>value</code> of the variable are often different. The
  variable is guaranteed to have the <code>value</code> only initialization, as other events may change its
  <code>current</code> value.</p>
<p>To get the <code>current</code> state of the variable:</p>
<r-code language="javascript">
  let current = x.get();
  // This can also be accessed through:
  current = x.variable.current;
</r-code>
<p>All of the properties of the variable are contained within the <code>variable</code> object that is up to date with
  the state provided by the <code>store</code>.</p>
<p>To change the <code>value</code> of the variable, or provide a <code>func</code> for evaluation, this can be done
  through setting the variable:</p>
<r-code language="javascript">
  x.set(42);
  x.set(null, 'y');
</r-code>
<p>
  In the second line, a function is provided referencing <code>y</code>, which will be evaluated as these variables
  live in the same <code>scope</code>.
</p>
<h2>Components &amp; Specs</h2>
<p>
  To define a new component you must first define a component spec. This lays out all of the properties that a
  component has as well as any events it may create.
</p>
<h3>Define a Spec</h3>
<p>For example, a slider has the following spec:</p>
<r-code language="javascript">
  export const SliderSpec = {
    name: 'slider',
    description: 'Range input or a slider!',
    properties: {
      value: { type: PropTypes.number, default: 0 },
      min: { type: PropTypes.number, default: 0 },
      max: { type: PropTypes.number, default: 100 },
      step: { type: PropTypes.number, default: 1 },
    },
    events: {
      change: { args: ['value'] },
    },
  };

  // Register this component spec
  store.dispatch(actions.createSpec(SliderSpec));
</r-code>
<p>
  The slider has a <code>min</code>, <code>max</code>, <code>step</code> and a <code>value</code>, when a user drags
  the slider, it creates a change event function and handler that has a single input to a function called "value" (which
  is not necessarily related to the <code>value</code> property 😕, more on that later.)
</p>
<p>
  The <code>name</code> of the spec will need to be referenced when creating components of this type. As such that
  needs to be registered with the store, shown in the last line of the example above.
</p>
<h3>Create a Component</h3>
<p>
  To create a range component, there must be a <code>spec</code> defined, and the properties and event handlers of this
  <em>instance</em> of the component can be defined. Note also that this component must live in a <code>scope</code>,
  which allows you to reference variables in that scope by name.
</p>
<r-code language="javascript">
  const slider = store.dispatch(actions.createComponent(
    'slider', 'scope',
    { value: { func: 'x' }, min: { value: 1 } },
    { change: { func: '{"x": value}' } },
  ));
</r-code>
<p>In this case the current sliders state can be accessed in a few ways:</p>
<r-code language="javascript">
  x.get() === slider.state.value
  x.get() === slider.component.properties.value.current
</r-code>
<p>
  Here we have created a component that is set up with <em>two-way-data-binding</em> to the variable <code>x</code>:
</p>
<ol>
  <li>
    <p>when <code>x</code> changes the <code>value</code> property of the slider will also change; and</p>
  </li>
  <li>
    <p>when the slider is interacted with and dispatches a <code>change</code> event, that event evaluates the
      <code>func</code>:</p>
  </li>
</ol>
<r-code language="javascript">
  function onChangeHandler(value) {
    return {"x": value};
  }
</r-code>
<p>This dictionary is used to update the variables in the state, and changes the value of <code>x</code>.</p>
<h3>Responding to Component Events</h3>
<p>As was mentioned before, you do not have to necessarily update the value of the slider (in this case it won’t move)
  or you may want to update multiple variables at the same time:</p>
<r-code language="javascript">
  slider.set({}, { change: { func: '{ x: value, y: value + 1, z: value * 2 }' }});
</r-code>
<p>This changes the slider component to declare that when a change event happens, update:</p>
<ul>
  <li>
    <p><code>x = value</code></p>
  </li>
  <li>
    <p><code>y = value + 1</code></p>
  </li>
  <li>
    <p><code>z = value * 2</code></p>
  </li>
</ul>
<p>Here the function has a single argument called “value” because that is what we defined in the spec:</p>
<r-code language="javascript">
  events: {
    change: { args: ['value'] },
  },
</r-code>
<p>We could change this to any other string or add other required entries for the event. These variable names will
  overwrite any variables named that in the scope (or globally).</p>
<p>Remember these are <strong>arbitrary</strong> evaluated strings, so you can do anything that Javascript can do. This
  includes executing user defined functions:</p>
<r-code language="javascript">
  function helloSliderInput(value) {
    console.log('The slider is updating to:', value);
    return { x: magicOtherFunction(value) }; // Or no return at all.
  }
  // Note, it does need to be accessible to the evaluation function!
  window.helloSliderInput = helloSliderInput;

  slider.set({}, { change: { func: 'helloSliderInput(value)' }});
</r-code>
<p>You also have access to other variables in the scope from the evaluated function:</p>
<r-code language="javascript">
  // ignore the value from the change event, and just set things to "y":
  slider.set({}, { change: { func: 'helloSliderInput(y)' }});
</r-code>
{% endblock %}

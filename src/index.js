const fs = require('fs');
const path = require('path');
const moment = require('moment');
const nunjucks = require('nunjucks');
require = require('esm')(module /*, options*/);
const jsdom = require("jsdom");
const { JSDOM } = jsdom;
const dom = (new JSDOM(``));
global.window = dom.window;
global.HTMLElement = dom.window.HTMLElement;
global.Element = dom.window.Element;
global.Document = dom.window.Document;
global.document = dom.window.document;
global.JSCompiler_renameProperty = function JSCopmiler_renameProperty(a, b) { return a };
global.navigator = dom.window.navigator;
const components = require('@curvenote/components').default;


const env = nunjucks.configure('src', { trimBlocks: true });


const site = {
  url: 'https://curvenote.dev',
  name: 'curvenote.dev',
  twitter: 'curvenote',
  github: 'curvenote',
  mailchimp: 'https://eepurl.com/gSTYyv',
  googleAnalyticsKey: 'G-4P4Z3X7QKB',
  theme: '#EE9127',
  logo: '/images/logo.png',
  icon: '/images/icon.png',
  date: moment().format('MMMM Do, YYYY'),
  dateISO: moment().toISOString(),
}

const nav = {
  type: "nav",
  label: "Documentation",
  children: [
    { url: "/", label: "curvenote.dev" },
    { url: "/introduction", label: "Introduction" },
    { url: "/getting-started", label: "Getting Started" },
    {
      type: "section", label: "Components", children: [
        { url: "/components", label: "Introduction" },
        { url: "/components/overview", label: "Overview" },
        { url: "/components/variable", label: "Variable" },
        { url: "/components/display", label: "Display" },
        { url: "/components/dynamic", label: "Dynamic" },
        { url: "/components/range", label: "Range" },
        { url: "/components/action", label: "Action" },
        { url: "/components/button", label: "Button" },
        { url: "/components/switch", label: "Switch" },
        { url: "/components/checkbox", label: "Checkbox" },
        { url: "/components/radio", label: "Radio" },
        { url: "/components/select", label: "Select" },
        { url: "/components/input", label: "Input" },
        { url: "/components/visible", label: "Visible" },
      ],
    },
    {
      type: "section", label: "Article", children: [
        { url: "/article", label: "Introduction" },
        { url: "/article/aside", label: "Aside" },
        { url: "/article/callout", label: "Callout" },
        { url: "/article/quote", label: "Quote" },
        { url: "/article/equation", label: "Equation" },
        { url: "/article/code", label: "Code" },
        { url: "/article/demo", label: "Demo" },
        { url: "/article/outline", label: "Outline" },
      ],
    },
    { url: "/svg", label: "Diagrams & SVGs" },
    { url: "/runtime", label: "Runtime" },
    {
      type: "section", label: "Showcase", children: [
        { url: "/showcase", label: "Overview" },
        { url: "/showcase/coordinate-transform", label: "Radial Coordinate" },
        { url: "/showcase/unit-circle", label: "Unit Circle" },
        { url: "/showcase/unit-star", label: "Unit Star" },
        { url: "/showcase/snells-law", label: "Snells Law" },
        { url: "/showcase/arc-tan", label: "Arc Tan" },
        { url: "/showcase/taylor-series", label: "Taylor Series" },
      ],
    },
  ],
};

function writePage(page, data = {}) {
  const pageNav = { ...nav, children: nav.children.map((item) => {
    if (item.type === "section") {
      const ret = {
        ...item,
        children: item.children.map((sub) => ({ ...sub, selected: sub.url === page.url })),
      };
      ret.open = ret.children.filter((sub) => sub.selected).length > 0;
      return ret;
    }
    return { ...item, selected: item.url === page.url };
  }) }

  const links = {};

  nav.children.forEach((item, i) => {
    if (item.url === page.url) {
      links.prev = nav.children[i - 1];
      links.next = nav.children[i + 1];
    }
    if (item.type === 'section') {
      item.children.forEach((subitem, j) => {
        if (subitem.url === page.url) {
          links.prev = item.children[j - 1] ? item.children[j - 1] : nav.children[i - 1];
          links.next = item.children[j + 1] ? item.children[j + 1] : nav.children[i + 1];
        }
      });
    }
  });
  if (links.prev && links.prev.type === 'section') {
    links.prev = { url: links.prev.children[0].url, label: links.prev.label };
  }
  if (links.next && links.next.type === 'section') {
    links.next = { url: links.next.children[0].url, label: links.next.label };
  }

  const indexHTML = nunjucks.render(page.tpl, { site, nav: pageNav, page, links, ...data });

  const loc = path.join(__dirname, '..', 'public', page.file);

  fs.writeFile(loc, indexHTML, (err) => {
    if (err) console.log('Problem!!', err);
  });
}

function convertSpec(component) {
  const spec = { ...component.spec};
  spec.properties = Object.entries(spec.properties).map(([_,v]) => v);
  spec.events = Object.entries(spec.events).map(([_,v]) => v);
  return spec;
}

const basePage = {
  isHtmlArticle: true,
  centered: false,
  twitter: '@rowancockett',
  date: new Date().toISOString(),
};


writePage({
  url: '/',
  tpl: 'content/404.tpl',
  file: '404.html',
});

writePage({
  url: '/',
  tpl: 'content/index.tpl',
  file: 'index.html',
  title: 'Interactive Scientific Writing',
  description: 'curvenote.dev: open source tools to promote and enable interactive scientific writing and explorable explanations',
  thumbnail: '/images/tangle.png',
  ...basePage,
  centered: true,
});

writePage({
  url: '/introduction',
  tpl: 'content/introduction.tpl',
  file: 'introduction.html',
  title: 'Introduction',
  description: 'Create beautiful reactive documents and explorable explanations using @curvenote/article',
  thumbnail: '/images/tangle.png',
  ...basePage,
});

writePage({
  url: '/getting-started',
  tpl: 'content/getting-started.tpl',
  file: 'getting-started.html',
  title: 'Getting Started',
  description: 'Including scripts in your HTML and installing from node',
  thumbnail: '/images/getting-started.png',
  ...basePage,
  centered: true,
});

writePage({
  url: '/components',
  tpl: 'content/components/index.tpl',
  file: 'components/index.html',
  title: '@curvenote/components',
  description: 'Use @curvenote/components to build explorable explanations',
  thumbnail: '/images/components.gif',
  ...basePage,
});

writePage({
  url: '/components/overview',
  tpl: 'content/components/overview.tpl',
  file: 'components/overview.html',
  title: 'Component Overview',
  description: 'Visual overview of @curvenote/components',
  thumbnail: '/images/components.gif',
  ...basePage,
  centered: true,
});


{ // Components
  writePage({
    url: '/components/variable',
    tpl: 'content/components/variable.tpl',
    file: 'components/variable.html',
    title: 'Variable',
    description: 'Use r-var as a web-component to create variables',
    thumbnail: '/images/components/var.png',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Variable) });


  writePage({
    url: '/components/display',
    tpl: 'content/components/display.tpl',
    file: 'components/display.html',
    title: 'display',
    description: 'Use r-display as a web-component to display variables',
    thumbnail: '/images/components/display.gif',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Display) });


  writePage({
    url: '/components/dynamic',
    tpl: 'content/components/dynamic.tpl',
    file: 'components/dynamic.html',
    title: 'dynamic',
    description: 'Use r-dynamic as a web-component to show dynamic text',
    thumbnail: '/images/components/dynamic.gif',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Dynamic) });


  writePage({
    url: '/components/range',
    tpl: 'content/components/range.tpl',
    file: 'components/range.html',
    title: 'range',
    description: 'Use r-range as a web-component to interact with a slider',
    thumbnail: '/images/components/range.gif',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Range) });


  writePage({
    url: '/components/action',
    tpl: 'content/components/action.tpl',
    file: 'components/action.html',
    title: 'action',
    description: 'Use r-action as a web-component to click on inline links',
    thumbnail: '/images/components/action.gif',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Action) });


  writePage({
    url: '/components/button',
    tpl: 'content/components/button.tpl',
    file: 'components/button.html',
    title: 'button',
    description: 'Use r-button as a web-component to click on buttons',
    thumbnail: '/images/components/button.gif',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Button) });


  writePage({
    url: '/components/switch',
    tpl: 'content/components/switch.tpl',
    file: 'components/switch.html',
    title: 'switch',
    description: 'Use r-switch as a web-component to create a switch',
    thumbnail: '/images/components/switch.gif',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Switch) });


  writePage({
    url: '/components/checkbox',
    tpl: 'content/components/checkbox.tpl',
    file: 'components/checkbox.html',
    title: 'checkbox',
    description: 'Use r-checkbox as a web-component to create a checkbox',
    thumbnail: '/images/components/checkbox.gif',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Checkbox) });


  writePage({
    url: '/components/radio',
    tpl: 'content/components/radio.tpl',
    file: 'components/radio.html',
    title: 'radio',
    description: 'Use r-radio as a web-component to create radio buttons',
    thumbnail: '/images/components/radio.gif',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Radio) });


  writePage({
    url: '/components/select',
    tpl: 'content/components/select.tpl',
    file: 'components/select.html',
    title: 'select',
    description: 'Use r-select as a web-component to create a dropdown selector',
    thumbnail: '/images/components/select.gif',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Select) });


  writePage({
    url: '/components/input',
    tpl: 'content/components/input.tpl',
    file: 'components/input.html',
    title: 'input',
    description: 'Use r-input as a web-component to get user input',
    thumbnail: '/images/components/input.gif',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Input) });


  writePage({
    url: '/components/visible',
    tpl: 'content/components/visible.tpl',
    file: 'components/visible.html',
    title: 'visible',
    description: 'Use r-visible as a web-component to show or hide content reactively',
    thumbnail: '/images/components/visible.gif',
    ...basePage,
    centered: true,
  }, { spec: convertSpec(components.Visible) });
}


{
  writePage({
    url: '/article',
    tpl: 'content/article/index.tpl',
    file: 'article/index.html',
    title: '@curvenote/article',
    description: 'Use @curvenote/article to build explorable explanations',
    thumbnail: '/images/components/visible.gif',
    ...basePage,
  });

  writePage({
    url: '/article/aside',
    tpl: 'content/article/aside.tpl',
    file: 'article/aside.html',
    title: '@curvenote/article Visual Overview',
    description: 'Visual aside of article components and layout',
    thumbnail: '/images/article/aside.png',
    ...basePage,
    centered: true,
  });
  writePage({
    url: '/article/callout',
    tpl: 'content/article/callout.tpl',
    file: 'article/callout.html',
    title: 'Callout',
    description: 'CSS for a callout text-block',
    thumbnail: '/images/article/callout.png',
    ...basePage,
    centered: true,
  });
  writePage({
    url: '/article/quote',
    tpl: 'content/article/quote.tpl',
    file: 'article/quote.html',
    title: 'Quote',
    description: 'CSS for a callout text-block',
    thumbnail: '/images/article/quote.png',
    ...basePage,
    centered: true,
  });
  writePage({
    url: '/article/equation',
    tpl: 'content/article/equation.tpl',
    file: 'article/equation.html',
    title: 'Equation',
    description: 'Create a katex equation web-component',
    thumbnail: '/images/article/equation.png',
    ...basePage,
  });
  writePage({
    url: '/article/code',
    tpl: 'content/article/code.tpl',
    file: 'article/code.html',
    title: 'Code',
    description: 'Show code with highlight.js',
    thumbnail: '/images/article/code.png',
    ...basePage,
    centered: true,
  });
  writePage({
    url: '/article/demo',
    tpl: 'content/article/demo.tpl',
    file: 'article/demo.html',
    title: 'Demo',
    description: 'Create an HTML demo automatically',
    thumbnail: '/images/article/demo.png',
    ...basePage,
    centered: true,
  });
  writePage({
    url: '/article/outline',
    tpl: 'content/article/outline.tpl',
    file: 'article/outline.html',
    title: 'Outline',
    description: 'Show a visual outline of your article',
    thumbnail: '/images/article/outline.gif',
    ...basePage,
    centered: true,
  });
}


writePage({
  url: '/svg',
  tpl: 'content/svg/index.tpl',
  file: 'svg/index.html',
  title: '@curvenote/svg',
  description: 'Create diagrams and reactive svgs in curvenote',
  thumbnail: '/images/svg/radius.png',
  ...basePage,
  centered: true,
});


writePage({
  url: '/runtime',
  tpl: 'content/runtime/index.tpl',
  file: 'runtime/index.html',
  title: '@curvenote/runtime',
  description: 'Introduction to the @curvenote/runtime package',
  thumbnail: '/images/tangle.png',
  ...basePage,
  centered: true,
});


const showcase = [
  {
    title: 'Coordinate Transform',
    uid: 'coordinate-transform',
    description: 'Transform between radial and cartesian coordinates.',
  },
  {
    uid: 'unit-circle',
    title: 'Unit Circle - Sin and Cos',
    description: 'Interactive definition of the unit circle',
  },
  {
    uid: 'unit-star',
    title: 'Unit Star',
    description: 'Interactive definition of the "unit star"',
  },
  {
    uid: 'snells-law',
    title: 'Snell\'s law',
    description: 'Reflection and refraction.',
  },
  {
    uid: 'arc-tan',
    title: 'Arc Tan',
    description: 'Visual exploration of arctan2',
  },
  {
    uid: 'taylor-series',
    title: 'Taylor Series',
    description: 'Taylor series expansion around sin(x)',
  }
].map(v => ({
  url: `/showcase/${v.uid}`,
  tpl: `content/showcase/${v.uid}.tpl`,
  file: `showcase/${v.uid}.html`,
  title: v.title,
  description: v.description,
  thumbnail: `/images/showcase/${v.uid}.gif`,
  ...basePage,
  centered: true,
}));

writePage({
  url: '/showcase',
  tpl: 'content/showcase/index.tpl',
  file: 'showcase/index.html',
  title: 'Showcase',
  description: 'Examples of using curvenote.dev',
  thumbnail: '/images/showcase/unit-circle.gif',
  ...basePage,
  centered: true,
}, {showcase});

showcase.forEach((s) => writePage(s));

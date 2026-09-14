api.map('gt', 'T');

// Navigate tabs like vim windows
api.map('<Ctrl-l>', 'E');
api.map('<Ctrl-h>', 'R');
api.map('<Ctrl-j>', 'R');
api.map('<Ctrl-k>', 'E');

settings.focusFirstCandidate = false;
settings.tabsThreshold = 0;


// name: Rosé Pine
// author: thuanowa
// license: unlicense
// upstream: https://github.com/rose-pine/surfingkeys/blob/main/dist/rose-pine.conf
// blurb: All natural pine, faux fur and a bit of soho vibes for the classy minimalist

const hintsCss =
  "font-size: 14pt; font-family: 'JetBrains Mono NL', 'Cascadia Code', 'Helvetica Neue', Helvetica, Arial, sans-serif; border: 0px; color: #e0def4 !important; background: #191724; background-color: #191724";

api.Hints.style(hintsCss);
api.Hints.style(hintsCss, "text");

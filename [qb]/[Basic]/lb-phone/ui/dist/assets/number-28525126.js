function o(e){return e&&t((e-32)*5/9,1)}function t(e,r=0){return Number(Math.round(Number(e+"e"+r))+"e-"+r)}const i=(e,r)=>r&&typeof e=="number"?e>=1e9?(e/1e9).toFixed(1).replace(/\.0$/,"")+"B":e>=1e6?(e/1e6).toFixed(1).replace(/\.0$/,"")+"M":e>=1e3?(e/1e3).toFixed(1).replace(/\.0$/,"")+"k":e.toString():e.toLocaleString();export{o as F,i as f,t as r};
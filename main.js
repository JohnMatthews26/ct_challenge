let request = require('request');
let rp = require('request-promise');

rp({
  method: 'GET',
  url: `https://bitbucket.org/clicktime/clicktime-public/raw/b17ff44ae338c7a7fc4ecd47e56a6974f49a62a8/Sample_ClickTime_Data.json`,
  encoding: null
}).then(function(json){
  let obj = JSON.parse(json);
  console.log(obj);
});

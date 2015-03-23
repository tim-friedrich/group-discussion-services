var args = require('system').args // (self) chart_type output_filename s1 s2 s3 s4 s5 s6 s7 s8 s9
var fs   = require('fs')
var page = require('webpage').create()

var D3_JS    = './vendor/assets/bower_components/d3/d3.js'
var NVD3_JS  = './vendor/assets/bower_components/nvd3/build/nv.d3.js'
var NVD3_CSS = './vendor/assets/bower_components/nvd3/build/nv.d3.css'
var CHART_STUB_HTML    = './lib/chart_image/chart_stub.html'
var CHART_GENERATOR_JS = './app/assets/javascripts/charts/' + args[1] + '.js'


// page.onConsoleMessage = function(msg){ console.log('Console message: ' + msg) }

page.onCallback = function(_res){
  page.render(args[2])
  // html content lives at: page.content
  phantom.exit(0)
}

page.onError = function(msg){
  console.log('Chart generation error: ' + msg)
  phantom.exit(1)
}

page.content = fs.read(
  fs.absolute(CHART_STUB_HTML)
).replace('{{css_path}}',
  'file://' + fs.absolute(NVD3_CSS)
)

var evaluate = function(){
  var functionName = Array.prototype.shift.apply(arguments);
  var argumentsArray = [].slice.call(arguments);
  return window[functionName]("chart", argumentsArray, false, {}, function(res){ window.callPhantom(res) });
}

if( page.injectJs(fs.absolute(D3_JS)) &&
    page.injectJs(fs.absolute(NVD3_JS)) &&
    page.injectJs(fs.absolute(CHART_GENERATOR_JS)) ){
  page.evaluate(evaluate, "generateChart_" + args[1], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11])
} else {
  page.onError('failed to inject scripts')
}

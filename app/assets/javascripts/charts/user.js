// This script is used for both: Interactive client code and image generation

var formatData = function(scaleValues){
  console.log(scaleValues)
  var normalizedValues = scaleValues.map(function(v){
    return parseInt(v) - 5;
  })

  return [
    {
      key: "Scale",
      values: [
        { "value": normalizedValues[0], "label": "N" },
        { "value": normalizedValues[1], "label": "E" },
        { "value": normalizedValues[2], "label": "C" },
        { "value": normalizedValues[3], "label": "A" },
        { "value": normalizedValues[4], "label": "O" },
        { "value": normalizedValues[5], "label": "LM" },
        { "value": normalizedValues[6], "label": "MM" },
        { "value": normalizedValues[7], "label": "SM" },
        { "value": normalizedValues[8], "label": "H" }
      ]
    }
  ]
}

window.generateChart_user = function(domid, isDynamic, scaleValues, cb) {
  nv.addGraph(function() {
    var svg = '#' + domid + ' svg'

    // white background
    // d3.select(svg).append("rect").attr("width", "100%").attr("height", "100%").attr("fill", "white")

    // create bar diagram
    var diagram = nv.models.discreteBarChart()
      .duration(isDynamic ? 250 : 0)
      .x(function(d){ return d.label })
      .y(function(d){ return d.value })
      .showYAxis(false)
      .valueFormat(function(value){ return value + 5 })
      .tooltips(false)
      .showValues(true)

    // insert data
    d3.select(svg)
      .datum(formatData(scaleValues))
      .call(diagram)

    // resize diagram if window gets resized
    if(isDynamic){ nv.utils.windowResize(diagram.update) }

    return diagram
  }, function(){
    cb && cb('success')
  });
};
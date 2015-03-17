// This script is used for both: Interactive client code and image generation

var formatData = function(data){
  var normalizedValues = data.map(function(v){
    return parseInt(v) - 5;
  })

  return [
    {
      key: "Scale",
      values: [
        { "value": normalizedValues[0], "label": "N",  "desc": "Neurotizismus" },
        { "value": normalizedValues[1], "label": "E",  "desc": "Extraversion" },
        { "value": normalizedValues[2], "label": "C",  "desc": "Gewissenhaftigkeit" },
        { "value": normalizedValues[3], "label": "A",  "desc": "Verträglichkeit" },
        { "value": normalizedValues[4], "label": "O",  "desc": "Offenheit für Neues" },
        { "value": normalizedValues[5], "label": "LM", "desc": "Bedürfnis nach Anerkennung und Leistung" },
        { "value": normalizedValues[6], "label": "MM", "desc": "Bedürfnis nach Macht und Einfluss" },
        { "value": normalizedValues[7], "label": "SM", "desc": "Bedürfnis nach Sicherheit und Ruhe" },
        { "value": normalizedValues[8], "label": "H",  "desc": "Ehrlichkeit" }
      ]
    }
  ]
}

window.generateChart_user = function(domid, data, isDynamic, options, cb) {
  if(!isDynamic){
    nv.fontHack = 27;
  }

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

    // size (easier via css for svg)
    // if(options.height){ diagram.height(options.height) }
    // if(options.width){ diagram.width(options.width) }

    // tooltips
    if(options.tooltips){
      diagram
        .tooltipContent(function(key, y, e, graph){
          return '<p>' + graph.point.desc + '</p>'
        })
        .tooltips(true)
    }

    // insert data
    d3.select(svg)
      .datum(formatData(data))
      .call(diagram)

    // resize diagram if window gets resized
    if(isDynamic){ nv.utils.windowResize(diagram.update) }

    return diagram
  }, function(){
    cb && cb('success')
  });
};
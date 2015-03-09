angular.module('discussionEdit').filter 'filterWithRange', ['$filter', ($filter) ->
  (collection, predicateObject) ->
    

    if predicateObject.range
      from = predicateObject.range.min || 0
      to = predicateObject.range.max || 100
      console.log from
      console.log to
      
      predicate = angular.copy(predicateObject)
      delete predicate.range
    
      output = []
      for record in collection
        if !record[predicateObject.range.modelAttr]
          record[predicateObject.range.modelAttr] = 0
        if record[predicateObject.range.modelAttr] >= from && record[predicateObject.range.modelAttr] <= to
          output.push record

    $filter('filter')(output, predicate)
]
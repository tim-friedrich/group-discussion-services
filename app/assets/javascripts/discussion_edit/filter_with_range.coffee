angular.module('discussionEdit').filter 'filterWithRange', ['$filter', ($filter) ->
  (collection, predicateObject) ->
    console.log predicateObject
    if predicateObject.age
      from = predicateObject.age[0] || 0
      to = predicateObject.age[1] || 100
    else
      from = 0
      to = 100
    
    predicateCopy = angular.copy(predicateObject)
    delete predicateCopy.age
        
    output = []
    for record in collection
      if !record.age#[predicateObject.range.modelAttr]
        record.age = 0
      if record.age >= from && record.age <= to
        output.push record

    $filter('filter')(output, predicateCopy)
]
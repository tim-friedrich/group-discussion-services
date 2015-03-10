angular.module('discussionEdit').filter 'filterWithRange', ['$filter', ($filter) ->
  (collection, predicateObject) ->
    if predicateObject.age
      from = predicateObject.age[0] || 0
      to = predicateObject.age[1] || 100
    else
      from = 0
      to = 100

    output = []
    for record in collection
      if !record.age
        record.age = 0
      if record.age >= from && record.age <= to
        output.push record

    predicateCopy = angular.copy(predicateObject)
    delete predicateCopy.age

    $filter('filter')(output, predicateCopy)
]
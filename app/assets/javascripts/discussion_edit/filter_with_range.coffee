angular.module('discussionEdit').filter 'filterWithRange', ['$filter', ($filter) ->
  (collection, predicateObject) ->
    if fromTo = predicateObject.age
      delete predicateObject.age
      output = []
      for record in collection
        if record.age && record.age >= fromTo.from && record.age <= fromTo.to
          output.push record
    else
      output = collection
    $filter('filter')(output, predicateObject)
]
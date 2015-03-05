angular.module('discussionEdit').filter 'ageRange', ->
  (collection, fromTo) ->
    if fromTo
      output = []
      for record in collection
        if record.age && record.age >= fromTo.from && record.age <= fromTo.to
          output.push record
      output
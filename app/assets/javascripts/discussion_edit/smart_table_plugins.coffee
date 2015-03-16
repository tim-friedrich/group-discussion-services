angular.module('smart-table').directive('stSliderSearch', [ ->
  return {
    require: '^stTable',
    restrict: 'A',
    link: (scope, element, attr, tableController) ->
      predicate = scope.$eval(attr.stSliderSearch)

      scope.$watch(attr.ngModel, (newValue, oldValue) ->
        console.log "a:", newValue
        if (newValue != oldValue)
          tableController.tableState().search ||= {};
          tableController.search(newValue, predicate)
      )
  }])


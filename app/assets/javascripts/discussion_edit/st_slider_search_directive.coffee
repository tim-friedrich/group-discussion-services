angular.module('smart-table').directive 'stSliderSearch', ->
  require: '^stTable',
  restrict: 'A',
  link: (scope, element, attr, tableController) ->
    predicate = scope.$eval(attr.stSliderSearch)

    scope.$watch attr.ngModel, (newValue, oldValue) ->
      console.log "a", attr.ngModel, newValue
      if (newValue != oldValue)
        tableController.tableState().search ||= {};
        tableController.search(newValue, predicate)



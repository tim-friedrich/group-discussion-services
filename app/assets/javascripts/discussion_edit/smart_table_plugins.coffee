angular.module('smart-table').directive('stRangeSearch', [ ->
  return {
    require: '^stTable',
    restrict: 'A',
    # scope:
    #   predicate: '=?stRangeSearch'
    # ,
    link: (scope, element, attr, tableController) ->
      predicate = attr.stRangeSearch

      scope.$watch(attr.ngModel, (newValue, oldValue) ->
        if (newValue != oldValue)
          tableController.tableState().search ||= {};
          tableController.search(newValue, predicate)
      )
  }])
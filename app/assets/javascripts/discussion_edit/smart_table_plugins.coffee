angular.module('smart-table').directive('stRangeSearch', ['$timeout', ($timeout) ->
  return {
    require: '^stTable',
    restrict: 'A',
    # scope:
    #   predicate: '=?stRangeSearch'
    # ,
    link: ($scope, element, attr, ctrl) ->
      $scope.predicate = attr.stRangeSearch
      
      # console.log("SUCCESS")
      tableCtrl = ctrl
      promise = null
      throttle = attr.stDelay || 400;

      $scope.$watch(attr.ngModel, (newValue, oldValue) ->
        if (newValue != oldValue) 
          ctrl.tableState().search = {};
          tableCtrl.search(newValue, "age")
      )

      #table state -> view
      # $scope.$watch(() ->
      #    return ctrl.tableState().search;
      # , (newValue, oldValue) ->
      #    predicateExpression = $scope.predicate || '$';
      #    if (newValue.predicateObject && newValue.predicateObject[predicateExpression] != element[0].value) 
      #        element[0].value = newValue.predicateObject[predicateExpression] || '';
      # , true)

      # # # #view -> table state
      # element.bind('input', (evt) ->
      #     evt = evt.originalEvent || evt;
      #     if (promise != null) 
      #         $timeout.cancel(promise);
          
      #     promise = $timeout(() ->
      #         tableCtrl.search(evt.target.value, scope.predicate || '')
      #         promise = null
      #     , throttle)
      # )
  }])
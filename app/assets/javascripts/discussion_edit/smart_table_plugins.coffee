angular.module('smart-table').directive('stRangeSearch', ['$timeout', ($timeout) ->
    return {
        require: '^stTable',
        restrict: 'A',
        $scope:
            predicate: '=?stRangeSearch'
        ,
        link: ($scope, element, attr, ctrl) ->
                $scope.predicate = attr.stRangeSearch
                $scope.stOldMin = 0
                $scope.stOldMax = 100
                
                # console.log("SUCCESS")
                tableCtrl = ctrl
                promise = null
                throttle = attr.stDelay || 400;

                $scope.$watch(attr.ngModelLow, (newValue, oldValue) ->
                    if (newValue != oldValue) 
                        ctrl.tableState().search = {};
                        $scope.stOldMin = newValue
                        tableCtrl.search({min: newValue, max: $scope.stOldMax, modelAttr: $scope.predicate}, 'range')
                )

                $scope.$watch(attr.ngModelHigh, (newValue, oldValue) ->
                    if (newValue != oldValue) 
                        ctrl.tableState().search = {};
                        $scope.stOldMax = newValue
                        tableCtrl.search({min: $scope.stOldMin, max: newValue, modelAttr: $scope.predicate}, 'range')
                )

                #table state -> view
                $scope.$watch(() ->
                   return ctrl.tableState().search;
                , (newValue, oldValue) ->
                   predicateExpression = $scope.predicate || '$';
                   if (newValue.predicateObject && newValue.predicateObject[predicateExpression] != element[0].value) 
                       element[0].value = newValue.predicateObject[predicateExpression] || '';
                , true)

                # #view -> table state
                element.bind('slider', (evt) ->
                    evt = evt.originalEvent || evt;
                    if (promise != null) 
                        $timeout.cancel(promise);
                    
                    promise = $timeout(() ->
                        tableCtrl.search(scope.predicate || '', attr.ngModelLow)
                        promise = null
                    , throttle)
                )
        
    }])
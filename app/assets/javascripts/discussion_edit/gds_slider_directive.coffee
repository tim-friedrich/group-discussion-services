angular.module('discussionEdit').directive 'gdsSlider', ->
  restrict: 'A'
  replace: true

  link: (scope, element, attrs) ->
    # init slider
    element.slider
      enabled: !!scope.$eval(attrs.gdsSliderEnable)

    # update scope when slider is slidden
    # TODO use change event when working upstream
    element.slider().on "slide", (event) ->
      scope.$apply ->
        scope[attrs.ngModel] = event.value

    # enable or disable slider
    scope.$watch attrs.gdsSliderEnable, (newValue) ->
      if(newValue)
        element.slider("enable")
        scope[attrs.ngModel] = element.slider("getValue")

      else if (newValue != undefined)
        element.slider("disable")
        scope[attrs.ngModel] = null

  template: '''
    <input type="text"></input>
  '''

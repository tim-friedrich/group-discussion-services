angular.module('discussionEdit').directive('gdsSlider', [ ->
  return {
    restrict: 'A',

    link: (scope, element, attr) ->
      #element.slider({});
      scope.$watch($(element?)?.find( ".slider-input" )?.eq( 0 )?.slider?, (isInitialized)->
        if isInitialized
          $(element).find( ".slider-input" ).eq( 0 ).slider("disable");
      )
      scope.$watch(attr.enable, (newValue, oldValue) ->
        if $(element).find( ".slider-input" ).eq( 0 ).slider?
          if(newValue)
            $(element).find( ".slider-input" ).eq( 0 ).slider("enable")
          else 
            $(element).find( ".slider-input" ).eq( 0 ).slider("disable");
      )
  }])


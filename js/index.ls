
angular.module \main, <[]>
  ..factory \skolto, -> (des) ->
    <- setTimeout _, 500
    target = $("##des")
    $("html,body").animate({scrollTop: target.offset!top}, 500)

  ..directive \delayBk, -> do
    restrict: \A
    link: (scope, e, attrs, ctrl) ->
      url = attrs["delayBk"]
      $ \<img/> .attr \src url .load ->
        $(@)remove!
        e.css "background-image": "url(#url)"
        setTimeout (-> e.toggle-class \visible), 100

  ..controller \section, <[$scope $element skolto]> ++ ($scope, $element, skolto) ->
    id = $element.attr \id
    $scope.$watch '$parent.ans', (-> if $scope.$parent.ans[id] => $element.addClass \active), true
    $scope.choice = (value, nid) -> 
      $scope.$parent.ans[id] = value
      $scope.$parent.ans[nid] = {}
      skolto nid


  ..controller \main, <[$scope]> ++ ($scope) ->
    setTimeout (-> $(\#footer)sticky topSpacing: 0), 0

    $scope.ans = {Q1: {}}


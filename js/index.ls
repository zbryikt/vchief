
angular.module \main, <[]>

  ..controller \section, <[$scope $element skolto]> ++ ($scope, $element, skolto) ->
    id = $element.attr \id
    $scope.chosen = 0
    $scope.$watch '$parent.ans', (-> 
      if !isNaN($scope.$parent.ans[id]) => $element.addClass \finish
      if $scope.$parent.ans[id] => $element.addClass \active
    ), true
    $scope.choice = (value, nid) -> 
      $scope.chosen = value
      $scope.$parent.ans[id] = value
      $scope.$parent.ans[nid] = {}
      skolto nid

  ..controller \main, <[$scope randomFact]> ++ ($scope, randomFact) ->
    setTimeout (-> $(\#footer)sticky topSpacing: 0), 0
    $scope.randomFact = randomFact!
    $scope.ans = {Q1: {}}


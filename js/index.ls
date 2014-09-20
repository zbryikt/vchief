angular.module \main, <[]>

  ..controller \section, <[$scope $element skolto]> ++ ($scope, $element, skolto) ->
    id = $element.attr \id
    $scope.chosen = 0
    $scope.$watch '$parent.ans', (-> 
      if !isNaN($scope.$parent.ans[id]) => $element.addClass \finish
      if $scope.$parent.ans[id] => $element.addClass \active
    ), true
    $scope.choice = (value, nid, ans) -> 
      $scope.chosen = value
      $scope.$parent.ans[id] = value
      $scope.$parent.ans[nid] = {}
      skolto nid
      name = if ans => \right else \wrong
      console.log $scope.$parent.sound[name].play
      setTimeout ->
        $scope.$parent.sound[name]
          ..load!
          ..play!
      , 100
  ..controller \main, <[$scope randomFact skolto]> ++ ($scope, randomFact, skolto) ->
    setTimeout (-> $(\#footer)sticky topSpacing: 0), 0
    $scope.randomFact = randomFact!
    $scope.ans = {Q1: {}}
    $scope.skolto = (nid) -> skolto nid
    addsound = (name) ->
      node = document.createElement \audio
      node.appendChild(document.createElement(\source) <<< src: "sound/#name.ogg", type: "audio/ogg")
      node.appendChild(document.createElement(\source) <<< src: "sound/#name.mp3", type: "audio/mpeg")
      node
    $scope.sound = do
      wrong: addsound \wrong
      right: addsound \right
    # preload image
    for i from 1 to 8
      img = new Image!
      img.src = "img/chief/Q#i.png"
    for i from 1 to 4
      for j from 1 to 4
        img = new Image!
        img.src = "img/choice/#i#j.png"

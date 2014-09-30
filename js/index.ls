angular.module \main, <[]>

  ..controller \section, <[$scope $element skolto]> ++ ($scope, $element, skolto) ->
    # debug
    $scope.q1 = do
      you: 75
      all: 45
    $scope.q2 = do
      data: [9 27 82 199 357 690 1158 1507 1497 1012 593 424 204 47 18]
      you: 75 
      all: 45
    $scope.q3 = do
      data: [11432 3501 583 5 1]
      you: 2
      all: 3
    $scope.q4Count = [23 55 5 10]
    $scope.q5Count = [23 55 5 10]
    $scope.q6Count = [25175 45000 45965 55000 62475]
    $scope.finalCount = [1 3 45 120 99 65 23 4]

    $scope.cid = id = $element.attr \id
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
    $scope.ans = {Q1: {}, Q2:{}, Q3:{}, Q4:{}, Q5:{}, Q6:{}, Q7:{}, Q8:{}}
    $scope.skolto = (nid) -> skolto nid, 0
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
    for i from 1 to 5
      for j from 1 to 4
        img = new Image!
        img.src = "img/choice/#i#j.png"


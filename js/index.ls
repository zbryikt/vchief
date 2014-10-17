angular.module \main, <[firebase]>

  ..controller \section, <[$scope $element $firebase skolto]> ++ ($scope, $element, $firebase, skolto) ->
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
      setTimeout ->
        $scope.$parent.sound[name]
          ..load!
          ..play!
      , 100
  ..controller \main, <[$scope $firebase randomFact skolto]> ++ ($scope, $firebase, randomFact, skolto) ->
    setTimeout (-> $(\#footer)sticky topSpacing: 0), 0
    $scope.db = db = $firebase(new Firebase "https://vchief.firebaseio.com/answer")$asArray!

    $scope.Q1 = do
      you: 75
      all: 45
      map: -> [0 86 80 67 50][it]
    $scope.Q2 = do
      data: [9 27 82 199 357 690 1158 1507 1497 1012 593 424 204 47 18]
      you: 75 
      all: 45
      map: -> (100 / 15) * ( (30 + it * 10) - 27 ) / 4
    $scope.Q3 = do
      data: [11432 3501 583 5 1]
      choice: [0 0 0 0 0]
      you: 0
      all: 0
      max: 0
      map: -> [0 1 2 4 0][it] * 20
    $scope.Q4 = do
      data: [[0] [0] [0] [0]]
      max: 0
      map: -> it - 1

    $scope.Q5 = do
      data: [7825 2810 967 2268]
      you: 1
    $scope.Q6 = do
      data: [[25175] [45000] [45965] [83333] [0] [0]]
      you: 55000
      map: (choice,role) -> 
        @data[if role=='you' => 4 else 5][0] = [0 25000 45000 65000 85000][choice]
    $scope.final = do
      data: [[0] [0] [0] [0] [0] [0] [0] [0]]
      max: 0
      you: 0
      all: 0


    $scope.alls = count: 0, Q1: 0, Q2: 0, Q3: 0, Q4: 0, Q5: 0, Q6: 0, Q7: 0

    $scope.randomFact = randomFact!
    $scope.ans = {Q1: {}}
    #$scope.ans = {Q1: {}, Q2:{}, Q3:{}, Q4:{}, Q5:{}, Q6:{}, Q7:{}, Q8:{}}
    #$scope.ans = Q1: {}, Q2:{}, Q3:{}, Q4:{}, Q5:{}
    $scope.trueAns = Q1: 1, Q2: 3, Q3: 4, Q4: 4, Q5: 4, Q6: 2, Q7: 4
    $scope.skolto = (nid) -> skolto nid, 0
    $scope.db.$watch (e) ->
      if e.event == "child_added" => 
        idx = $scope.db.$indexFor e.key
        item = $scope.db[idx]
        $scope.alls.count++
        count = 0
        for k of $scope.alls =>
          if k in <[count Q3]> => continue
          if !isNaN(item[k]) and $scope[k] and $scope[k]map =>
            $scope.alls[k] += $scope[k]map item[k], 'all'
          if $scope.trueAns[k] == item[k] => count++
        for k of $scope.alls =>
          if $scope[k] => 
            $scope[k].all = $scope.alls[k] / $scope.alls.count
        if !isNaN(item.Q3) => if item.Q3 < $scope.Q3.choice.length =>
          $scope.Q3.choice[item.Q3]++
          if $scope.Q3.max < $scope.Q3.choice[item.Q3] =>
            $scope.Q3.max = $scope.Q3.choice[item.Q3]
            $scope.Q3.all = $scope.Q3.map item.Q3
        if !isNaN(item.Q4) => $scope.Q4.max >?= (++$scope.Q4.data[item.Q4 - 1][0])
        $scope.final.data[count][0]++
        if $scope.final.data[count][0] > $scope.final.max => $scope.final.max = $scope.final.data[count][0]
    $scope.$watch 'ans', -> 
      $scope.final.you = 0
      for i from 1 to 7 =>
        n = "Q#i"
        if !isNaN($scope.ans[n]) and $scope[n] and $scope[n]map => 
          $scope[n]you = $scope[n]map $scope.ans[n], 'you'
        if $scope.ans[n] == $scope.trueAns[n] => $scope.final.you++
      if !isNaN($scope.ans["Q7"]) =>
        $scope.db.$add $scope.ans
    , true
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
    $('\.btn-base').attr src: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAALYAAAEHCAMAAAA0z0xSAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAAZQTFRF////AAAAVcLTfgAAAAF0Uk5TAEDm2GYAAABISURBVHja7MExAQAAAMKg9U9tDQ+gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAODIBBgAvAEAATkNxaoAAAAASUVORK5CYII="
    door-animation = ->
      [L,R] = [$(\#bhs-door-l), $(\#bhs-door-r)]
      [w,h] = [L.width!, L.height!]
      if w/h > 900/474 => w = (h / 474) * 900
      L.animate { left: "#{w * -0.164}px" }, 3000
      R.animate { left: "#{w *  0.156}px" }, 3000

    door-animation!

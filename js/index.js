// Generated by LiveScript 1.2.0
var x$;
x$ = angular.module('main', ['firebase']);
x$.controller('section', ['$scope', '$element', '$firebase', 'skolto'].concat(function($scope, $element, $firebase, skolto){
  var id;
  $scope.cid = id = $element.attr('id');
  $scope.chosen = 0;
  $scope.$watch('$parent.ans', function(){
    if (!isNaN($scope.$parent.ans[id])) {
      $element.addClass('finish');
    }
    if ($scope.$parent.ans[id]) {
      return $element.addClass('active');
    }
  }, true);
  return $scope.choice = function(value, nid, ans){
    var name;
    $scope.chosen = value;
    $scope.$parent.ans[id] = value;
    $scope.$parent.ans[nid] = {};
    skolto(nid);
    name = ans ? 'right' : 'wrong';
    return setTimeout(function(){
      var x$;
      x$ = $scope.$parent.sound[name];
      x$.load();
      x$.play();
      return x$;
    }, 100);
  };
}));
x$.controller('main', ['$scope', '$firebase', 'randomFact', 'skolto'].concat(function($scope, $firebase, randomFact, skolto){
  var db, addsound, i$, i, img, lresult$, j$, j, results$ = [];
  setTimeout(function(){
    return $('#footer').sticky({
      topSpacing: 0
    });
  }, 0);
  $scope.db = db = $firebase(new Firebase("https://vchief.firebaseio.com/answer")).$asArray();
  $scope.Q1 = {
    you: 75,
    all: 45,
    map: function(it){
      return [0, 86, 80, 67, 50][it];
    }
  };
  $scope.Q2 = {
    data: [9, 27, 82, 199, 357, 690, 1158, 1507, 1497, 1012, 593, 424, 204, 47, 18],
    you: 75,
    all: 45,
    map: function(it){
      return (100 / 15) * ((30 + it * 10) - 27) / 4;
    }
  };
  $scope.Q3 = {
    data: [11432, 3501, 583, 5, 1],
    you: 0,
    all: 0,
    map: function(it){
      return [0, 1, 2, 4, 0][it] * 20;
    }
  };
  $scope.Q4 = {
    data: [[0], [0], [0], [0]],
    max: 0
  };
  $scope.Q5 = {
    data: [7825, 2810, 967, 2268],
    you: 1
  };
  $scope.Q6 = {
    data: [[25175], [45000], [45965], [83333], [0], [0]],
    you: 55000,
    map: function(choice, role){
      return this.data[role === 'you' ? 4 : 5][0] = [0, 25000, 45000, 65000, 85000][choice];
    }
  };
  $scope.final = {
    data: [[0], [0], [0], [0], [0], [0], [0], [0]],
    max: 0,
    you: 0,
    all: 0
  };
  $scope.alls = {
    count: 0,
    Q1: 0,
    Q2: 0,
    Q3: 0,
    Q4: 0,
    Q5: 0,
    Q6: 0,
    Q7: 0
  };
  $scope.randomFact = randomFact();
  $scope.ans = {
    Q1: {}
  };
  $scope.trueAns = {
    Q1: 1,
    Q2: 3,
    Q3: 4,
    Q4: 4,
    Q5: 4,
    Q6: 2,
    Q7: 4
  };
  $scope.skolto = function(nid){
    return skolto(nid, 0);
  };
  $scope.db.$watch(function(e){
    var idx, item, count, k, ref$, ref1$;
    if (e.event === "child_added") {
      idx = $scope.db.$indexFor(e.key);
      item = $scope.db[idx];
      $scope.alls.count++;
      count = 0;
      for (k in $scope.alls) {
        if (k === "count") {
          continue;
        }
        if (!isNaN(item[k]) && $scope[k] && $scope[k].map) {
          $scope.alls[k] += $scope[k].map(item[k], 'all');
        }
        if ($scope.trueAns[k] === item[k]) {
          count++;
        }
      }
      for (k in $scope.alls) {
        if ($scope[k]) {
          $scope[k].all = $scope.alls[k] / $scope.alls.count;
        }
      }
      if (!isNaN(item.Q4)) {
        (ref$ = $scope.Q4).max >= (ref1$ = ++$scope.Q4.data[item.Q4 - 1][0]) || (ref$.max = ref1$);
      }
      $scope.final.data[count][0]++;
      if ($scope.final.data[count][0] > $scope.final.max) {
        return $scope.final.max = $scope.final.data[count][0] / 100;
      }
    }
  });
  $scope.$watch('ans', function(){
    var i$, i, n;
    $scope.final.you = 0;
    for (i$ = 1; i$ <= 7; ++i$) {
      i = i$;
      n = "Q" + i;
      if (!isNaN($scope.ans[n]) && $scope[n] && $scope[n].map) {
        $scope[n].you = $scope[n].map($scope.ans[n], 'you');
      }
      if ($scope.ans[n] === $scope.trueAns[n]) {
        $scope.final.you++;
      }
    }
    if (!isNaN($scope.ans["Q7"])) {
      return $scope.db.$add($scope.ans);
    }
  }, true);
  addsound = function(name){
    var node, ref$;
    node = document.createElement('audio');
    node.appendChild((ref$ = document.createElement('source'), ref$.src = "sound/" + name + ".ogg", ref$.type = "audio/ogg", ref$));
    node.appendChild((ref$ = document.createElement('source'), ref$.src = "sound/" + name + ".mp3", ref$.type = "audio/mpeg", ref$));
    return node;
  };
  $scope.sound = {
    wrong: addsound('wrong'),
    right: addsound('right')
  };
  for (i$ = 1; i$ <= 8; ++i$) {
    i = i$;
    img = new Image();
    img.src = "img/chief/Q" + i + ".png";
  }
  for (i$ = 1; i$ <= 5; ++i$) {
    i = i$;
    lresult$ = [];
    for (j$ = 1; j$ <= 4; ++j$) {
      j = j$;
      img = new Image();
      lresult$.push(img.src = "img/choice/" + i + j + ".png");
    }
    results$.push(lresult$);
  }
  return results$;
}));
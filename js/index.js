// Generated by LiveScript 1.2.0
var x$;
x$ = angular.module('main', []);
x$.controller('section', ['$scope', '$element', 'skolto'].concat(function($scope, $element, skolto){
  var id;
  id = $element.attr('id');
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
    console.log($scope.$parent.sound[name].play);
    return setTimeout(function(){
      var x$;
      x$ = $scope.$parent.sound[name];
      x$.load();
      x$.play();
      return x$;
    }, 100);
  };
}));
x$.controller('main', ['$scope', 'randomFact'].concat(function($scope, randomFact){
  var addsound, i$, i, img, lresult$, j$, j, results$ = [];
  setTimeout(function(){
    return $('#footer').sticky({
      topSpacing: 0
    });
  }, 0);
  $scope.randomFact = randomFact();
  $scope.ans = {
    Q1: {}
  };
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
  for (i$ = 1; i$ <= 4; ++i$) {
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
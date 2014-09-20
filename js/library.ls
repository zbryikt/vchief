angular.module \main

  ..factory \skolto, -> (des, delay=500) ->
    <- setTimeout _, delay
    target = $("##des")
    $("html,body").animate({scrollTop: target.offset!top}, 500)

  ..factory \randomFact, ($http) -> -> 
    ret = [parseInt(Math.random!*100) for i from 0 to parseInt(Math.random!*10) + 5]map ->
      s = sentence[it]
      s[parseInt(Math.random!*s.length)]
    ret.join("，") + "。"

  ..directive \delayBk, -> do
    restrict: \A
    link: (scope, e, attrs, ctrl) ->
      url = attrs["delayBk"]
      $ \<img/> .attr \src url .load ->
        $(@)remove!
        e.css "background-image": "url(#url)"
        setTimeout (-> e.toggle-class \visible), 100


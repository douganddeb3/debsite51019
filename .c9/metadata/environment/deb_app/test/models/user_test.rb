{"filter":false,"title":"user_test.rb","tooltip":"/deb_app/test/models/user_test.rb","undoManager":{"mark":1,"position":1,"stack":[[{"start":{"row":69,"column":5},"end":{"row":70,"column":0},"action":"insert","lines":["",""],"id":14},{"start":{"row":70,"column":0},"end":{"row":70,"column":2},"action":"insert","lines":["  "]},{"start":{"row":70,"column":2},"end":{"row":71,"column":0},"action":"insert","lines":["",""]},{"start":{"row":71,"column":0},"end":{"row":71,"column":2},"action":"insert","lines":["  "]}],[{"start":{"row":71,"column":2},"end":{"row":87,"column":5},"action":"insert","lines":["test \"feed should have the right posts\" do","    michael = users(:michael)","    archer  = users(:archer)","    lana    = users(:lana)","    # Posts from followed user","    lana.microposts.each do |post_following|","      assert michael.feed.include?(post_following)","    end","    # Posts from self","    michael.microposts.each do |post_self|","      assert michael.feed.include?(post_self)","    end","    # Posts from unfollowed user","    archer.microposts.each do |post_unfollowed|","      assert_not michael.feed.include?(post_unfollowed)","    end","  end"],"id":15}]]},"ace":{"folds":[],"scrolltop":1238,"scrollleft":0,"selection":{"start":{"row":87,"column":5},"end":{"row":87,"column":5},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":76,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1543353575362,"hash":"dacb21496a84d050009b12baf1675c6c01b1084b"}
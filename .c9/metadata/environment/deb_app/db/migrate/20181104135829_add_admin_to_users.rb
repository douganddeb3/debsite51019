{"filter":false,"title":"20181104135829_add_admin_to_users.rb","tooltip":"/deb_app/db/migrate/20181104135829_add_admin_to_users.rb","undoManager":{"mark":1,"position":1,"stack":[[{"start":{"row":1,"column":2},"end":{"row":3,"column":5},"action":"remove","lines":["def change","    add_column :users, :admin, :boolean","  end"],"id":2}],[{"start":{"row":1,"column":2},"end":{"row":3,"column":5},"action":"insert","lines":["def change","    add_column :users, :admin, :boolean, default: false","  end"],"id":3}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":3,"column":5},"end":{"row":3,"column":5},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":29,"mode":"ace/mode/ruby"}},"timestamp":1541340082203,"hash":"8be84ff315fcea0d4a8498740a758cdc557d50cc"}
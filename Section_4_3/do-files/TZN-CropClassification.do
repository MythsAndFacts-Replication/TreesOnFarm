*--- Crop Classification - Initial 

	cap gen crop_type=""
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==33
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==48
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==88
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==90
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==91
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==95
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==100
	replace crop_type="NA" if crop_id==101
	replace crop_type="Tree" if crop_id==63
	replace crop_type="Tree" if crop_id==64
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==24
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==16
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==212
	replace crop_type="NA" if crop_id==211
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==87
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==51
	replace crop_type="Tree" if crop_id==304
	replace crop_type="Small trees or shrubs" if crop_id==55
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==22
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==41
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==60
	replace crop_type="Small trees or shrubs" if crop_id==39
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==47
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==13
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==53
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==19
	replace crop_type="Tree" if crop_id==57
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==12
	replace crop_type="Tree" if crop_id==99
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==52
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==92
	replace crop_type="Tree" if crop_id==68
	replace crop_type="Small trees or shrubs" if crop_id==205
	replace crop_type="Tree" if crop_id==81
	replace crop_type="Tree" if crop_id==203
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==75
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==34
	replace crop_type="Small trees or shrubs" if crop_id==83
	replace crop_type="Small trees or shrubs" if crop_id==84
	replace crop_type="Small trees or shrubs" if crop_id==204
	replace crop_type="Tree" if crop_id==74
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==70
	replace crop_type="Tree" if crop_id==76
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==26
	replace crop_type="Tree" if crop_id==44
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==65
	replace crop_type="NA" if crop_id==998
	replace crop_type="Tree" if crop_id==301
	replace crop_type="NA" if crop_id==202
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==14
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==305
	replace crop_type="Tree" if crop_id==73
	replace crop_type="Tree" if crop_id==79
	replace crop_type="Tree" if crop_id==38
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==11
	replace crop_type="Small trees or shrubs" if crop_id==851
	replace crop_type="Small trees or shrubs" if crop_id==852
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==59
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==62
	replace crop_type="Tree" if crop_id==69
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==23
	replace crop_type="Tree" if crop_id==80
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==43
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==300
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==78
	replace crop_type="Tree" if crop_id==77
	replace crop_type="Tree" if crop_id==201
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==27
	replace crop_type="Tree" if crop_id==303
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==15
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==37
	replace crop_type="Tree" if crop_id==306
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==94
	replace crop_type="Tree" if crop_id==97
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==210
	replace crop_type="Tree" if crop_id==200
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==93
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==32
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==50
	replace crop_type="Small trees or shrubs" if crop_id==54
	replace crop_type="Tree" if crop_id==45
	replace crop_type="Tree" if crop_id==56
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==25
	replace crop_type="Tree" if crop_id==66
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==35
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==96
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==21
	replace crop_type="Tree" if crop_id==46
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==89
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==61
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==86
	replace crop_type="Tree" if crop_id==67
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==58
	replace crop_type="Small trees or shrubs" if crop_id==18
	replace crop_type="Tree" if crop_id==98
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==42
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==31
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==17
	replace crop_type="Tree-like plants" if crop_id==71
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==302
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==36
	replace crop_type="Tree" if crop_id==72
	replace crop_type="Tree" if crop_id==82

	* Watermelon - Citrullus lanatus - Plant/Herb/Grass/Roots
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==95
	* Soursop - Wild Soursop - Tree - http://eol.org/pages/1054865/overview
	replace crop_type="Tree" if crop_id==213
	* Cucumber - Cucumis sativus - Plant/Herb/Grass/Roots - http://eol.org/pages/584402/overview
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==93
	* Cocoyams -  Plant/Herb/Grass/Roots 
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==25

	replace crop_type="NA" if crop_type==""

*--- Tree Classification - Initial 

	gen tree_type=""
	replace tree_type="Tree Crops" if crop_id==57
replace tree_type="Tree Crops" if crop_id==44
replace tree_type="Tree Crops" if crop_id==301
replace tree_type="Tree Crops" if crop_id==56
replace tree_type="Tree Crops" if crop_id==66
replace tree_type="Tree Crops" if crop_id==46
replace tree_type="Trees for timber and fuelwood" if crop_id==303
replace tree_type="Trees for timber and fuelwood" if crop_id==306
replace tree_type="Fruit Tree" if crop_id==63
replace tree_type="Fruit Tree" if crop_id==64
replace tree_type="Fruit Tree" if crop_id==99
replace tree_type="Fruit Tree" if crop_id==68
replace tree_type="Fruit Tree" if crop_id==81
replace tree_type="Fruit Tree" if crop_id==203
replace tree_type="Fruit Tree" if crop_id==74
replace tree_type="Fruit Tree" if crop_id==76
replace tree_type="Fruit Tree" if crop_id==73
replace tree_type="Fruit Tree" if crop_id==79
replace tree_type="Fruit Tree" if crop_id==38
replace tree_type="Fruit Tree" if crop_id==69
replace tree_type="Fruit Tree" if crop_id==80
replace tree_type="Fruit Tree" if crop_id==77
replace tree_type="Fruit Tree" if crop_id==201
replace tree_type="Fruit Tree" if crop_id==97
replace tree_type="Fruit Tree" if crop_id==200
replace tree_type="Fruit Tree" if crop_id==45
replace tree_type="Fruit Tree" if crop_id==67
replace tree_type="Fruit Tree" if crop_id==98
replace tree_type="Fruit Tree" if crop_id==72
replace tree_type="Fruit Tree" if crop_id==82
replace tree_type="Trees for timber and fuelwood" if crop_id==304
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==33
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==48
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==88
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==90
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==91
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==95
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==100
replace tree_type="NA" if crop_id==101
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==24
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==16
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==212
replace tree_type="NA" if crop_id==211
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==87
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==51
replace tree_type="Tree Crops" if crop_id==55
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==22
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==41
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==60
replace tree_type="Fruit Tree" if crop_id==39
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==47
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==13
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==53
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==19
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==12
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==52
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==92
replace tree_type="Fruit Tree" if crop_id==205
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==75
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==34
replace tree_type="Fruit Tree" if crop_id==83
replace tree_type="Fruit Tree" if crop_id==84
replace tree_type="Fruit Tree" if crop_id==204
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==70
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==26
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==65
replace tree_type="NA" if crop_id==998
replace tree_type="NA" if crop_id==202
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==14
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==305
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==11
replace tree_type="Fruit Tree" if crop_id==851
replace tree_type="Fruit Tree" if crop_id==852
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==59
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==62
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==23
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==43
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==300
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==78
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==27
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==15
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==37
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==94
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==210
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==93
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==32
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==50
replace tree_type="Tree Crops" if crop_id==54
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==25
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==35
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==96
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==21
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==89
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==61
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==86
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==58
replace tree_type="Tree Crops" if crop_id==18
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==42
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==31
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==17
replace tree_type="Fruit Tree" if crop_id==71
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==302
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==36
replace tree_type="Tree Crops" if crop_id==213

replace tree_type="NA" if tree_type==""






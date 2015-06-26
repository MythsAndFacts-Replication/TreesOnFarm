*--- Crop Classification - Initial 

	cap gen crop_type=""
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==34
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==83
	replace crop_type="Tree" if crop_code==35
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==57
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==51
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==4
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==7
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==12
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==13
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==14
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==16
	replace crop_type="NA" if crop_code==17
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==20
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==21
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==25
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==26
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==28
	replace crop_type="NA" if crop_code==29
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==30
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==31
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==36
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==39
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==40
	replace crop_type="NA" if crop_code==50
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==56
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==59
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==67
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==68
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==69
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==71
	replace crop_type="NA" if crop_code==75
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==79
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==80
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==81
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==85
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==97
	replace crop_type="NA" if crop_code==101
	replace crop_type="NA" if crop_code==104
	replace crop_type="NA" if crop_code==107
	replace crop_type="NA" if crop_code==108
	replace crop_type="NA" if crop_code==112
	replace crop_type="NA" if crop_code==116
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==8
	replace crop_type="NA" if crop_code==103
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==63
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==78
	replace crop_type="Small trees or shrubs" if crop_code==77
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==62
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==76
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==113
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==18
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==6
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==109
	replace crop_type="NA" if crop_code==114
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==22
	replace crop_type="NA" if crop_code==9
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==5
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==38
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==61
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==49
	replace crop_type="Small trees or shrubs" if crop_code==66
	replace crop_type="Tree" if crop_code==48
	replace crop_type="Tree" if crop_code==47
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==58
	replace crop_type="Tree" if crop_code==89
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==98
	replace crop_type="NA" if crop_code==99
	replace crop_type="NA" if crop_code==115
	replace crop_type="NA" if crop_code==115
	replace crop_type="NA" if crop_code==117
	replace crop_type="NA" if crop_code==118
	replace crop_type="NA" if crop_code==119
	replace crop_type="NA" if crop_code==120
	replace crop_type="NA" if crop_code==123
	replace crop_type="Tree" if crop_code==46
	replace crop_type="Tree" if crop_code==45
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==2
	replace crop_type="Small trees or shrubs" if crop_code==44
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==60
	replace crop_type="Tree" if crop_code==65
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==24
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==43
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==64
	replace crop_type="Tree" if crop_code==82
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==37
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==55
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==3
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==15
	replace crop_type="NA" if crop_code==86
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==74
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==106
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==23
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==73
	replace crop_type="NA" if crop_code==111
	replace crop_type="Small trees or shrubs" if crop_code==72
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==11
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==54
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==10
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==53
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==33
	replace crop_type="Small trees or shrubs" if crop_code==19
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==52
	replace crop_type="Tree" if crop_code==105
	replace crop_type="Small trees or shrubs" if crop_code==32
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==27
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==70
	replace crop_type="Plant/Herb/Grass/Roots" if crop_code==1
	replace crop_type="Tree-like plants" if crop_code==42
	replace crop_type="Tree" if crop_code==84
	replace crop_type="Tree" if crop_code==41
	replace crop_type="NA" if crop_type==""

*--- Tree Classification - Initial 


cap gen tree_type=""
replace tree_type="Trees for timber and fuelwood" if crop_code==89
replace tree_type="Fruit Tree" if crop_code==35
replace tree_type="Fruit Tree" if crop_code==48
replace tree_type="Fruit Tree" if crop_code==47
replace tree_type="Fruit Tree" if crop_code==46
replace tree_type="Fruit Tree" if crop_code==45
replace tree_type="Fruit Tree" if crop_code==65
replace tree_type="Fruit Tree" if crop_code==82
replace tree_type="Fruit Tree" if crop_code==105
replace tree_type="Fruit Tree" if crop_code==84
replace tree_type="Fruit Tree" if crop_code==41
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==34
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==83
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==57
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==51
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==4
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==7
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==12
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==13
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==14
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==16
replace tree_type="NA" if crop_code==17
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==20
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==21
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==25
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==26
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==28
replace tree_type="NA" if crop_code==29
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==30
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==31
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==36
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==39
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==40
replace tree_type="NA" if crop_code==50
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==56
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==59
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==67
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==68
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==69
replace tree_type="NA" if crop_code==71
replace tree_type="NA" if crop_code==75
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==79
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==80
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==81
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==85
replace tree_type="NA" if crop_code==97
replace tree_type="NA" if crop_code==101
replace tree_type="NA" if crop_code==104
replace tree_type="NA" if crop_code==107
replace tree_type="NA" if crop_code==108
replace tree_type="NA" if crop_code==112
replace tree_type="NA" if crop_code==116
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==8
replace tree_type="NA" if crop_code==103
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==63
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==78
replace tree_type="Tree Crops" if crop_code==77
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==62
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==76
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==113
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==18
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==6
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==109
replace tree_type="NA" if crop_code==114
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==22
replace tree_type="NA" if crop_code==9
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==5
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==38
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==61
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==49
replace tree_type="Fruit Tree" if crop_code==66
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==58
replace tree_type="NA" if crop_code==98
replace tree_type="NA" if crop_code==99
replace tree_type="NA" if crop_code==115
replace tree_type="NA" if crop_code==115
replace tree_type="NA" if crop_code==117
replace tree_type="NA" if crop_code==118
replace tree_type="NA" if crop_code==119
replace tree_type="NA" if crop_code==120
replace tree_type="NA" if crop_code==123
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==2
replace tree_type="Fruit Tree" if crop_code==44
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==60
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==24
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==43
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==64
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==37
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==55
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==3
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==15
replace tree_type="NA" if crop_code==86
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==74
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==106
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==23
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==73
replace tree_type="NA" if crop_code==111
replace tree_type="Tree Crops" if crop_code==72
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==11
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==54
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==10
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==53
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==33
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==19
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==52
replace tree_type="Tree Crops" if crop_code==32
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==27
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==70
replace tree_type="Plant/Herb/Grass/Roots" if crop_code==1
replace tree_type="Fruit Tree" if crop_code==42

replace tree_type=crop_type if tree_type==""


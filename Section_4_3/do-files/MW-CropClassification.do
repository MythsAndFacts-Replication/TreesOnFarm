*--- Crop Classification - Initial 

	gen crop_type=""
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==43
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==46
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==27
	replace crop_type="NA" if crop_id==41
	replace crop_type="NA" if crop_id==42
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==47
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==30
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==44
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==5
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==6
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==7
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==8
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==9
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==10
	replace crop_type="Small trees or shrubs" if crop_id==2
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==28
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==38
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==39
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==35
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==32
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==17
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==18
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==19
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==20
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==21
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==22
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==23
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==24
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==25
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==26
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==16
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==36
	replace crop_type="Small trees or shrubs" if crop_id==12
	replace crop_type="Tree" if crop_id==6
	replace crop_type="Tree" if crop_id==5
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==45
	replace crop_type="NA" if crop_id==48
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==33
	replace crop_type="Tree" if crop_id==15
	replace crop_type="Tree" if crop_id==4
	replace crop_type="Tree" if crop_id==11
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==1
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==2
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==3
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==4
	replace crop_type="Small trees or shrubs" if crop_id==17
	replace crop_type="Small trees or shrubs" if crop_id==10
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==29
	replace crop_type="Tree" if crop_id==9
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==11
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==12
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==13
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==14
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==15
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==16
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==31
	replace crop_type="Tree" if crop_id==14
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==37
	replace crop_type="Small trees or shrubs" if crop_id==3
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==1
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==40
	replace crop_type="Plant/Herb/Grass/Roots" if crop_id==34
	replace crop_type="Tree-like plants" if crop_id==7
	replace crop_type="Tree" if crop_id==8
	replace crop_type="Tree" if crop_id==13
	replace crop_type="Tree" if crop_id==14


*--- Tree Classification - Initial
	gen tree_type=""
	replace tree_type="Fruit Tree" if crop_id==6
replace tree_type="Fruit Tree" if crop_id==5
replace tree_type="Fruit Tree" if crop_id==15
replace tree_type="Fruit Tree" if crop_id==4
replace tree_type="Fruit Tree" if crop_id==11
replace tree_type="Fruit Tree" if crop_id==9
replace tree_type="Fruit Tree" if crop_id==14
replace tree_type="Fruit Tree" if crop_id==8
replace tree_type="Fruit Tree" if crop_id==13
replace tree_type="Fruit Tree" if crop_id==14
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==43
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==46
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==27
replace tree_type="NA" if crop_id==41
replace tree_type="NA" if crop_id==42
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==47
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==30
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==44
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==5
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==6
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==7
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==8
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==9
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==9
replace tree_type="Tree Crops" if crop_id==2
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==28
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==38
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==39
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==35
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==32
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==17
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==18
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==19
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==20
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==21
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==22
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==23
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==24
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==25
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==26
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==16
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==36
replace tree_type="Fruit Tree" if crop_id==12
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==45
replace tree_type="NA" if crop_id==48
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==33
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==1
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==2
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==3
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==4
replace tree_type="Tree Crops" if crop_id==17
replace tree_type="Fruit Tree" if crop_id==10
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==29
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==11
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==12
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==13
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==14
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==15
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==16
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==31
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==37
replace tree_type="Tree Crops" if crop_id==3
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==1
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==40
replace tree_type="Plant/Herb/Grass/Roots" if crop_id==34
replace tree_type="Fruit Tree" if crop_id==7



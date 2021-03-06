*--- Crop Classification - Initial 

	cap gen crop_type=""
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1093
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2291
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2290
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1122
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1120
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1121
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2280
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1123
	replace crop_type="Tree" if cropcode==2270
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1091
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1061
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2260
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2250
	replace crop_type="Tree" if cropcode==1124
	replace crop_type="Small trees or shrubs" if cropcode==2240
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2181
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2141
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2230
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2220
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1070
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2142
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1092
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1062
	replace crop_type="Tree" if cropcode==2210
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1051
	replace crop_type="Tree" if cropcode==3232
	replace crop_type="Tree" if cropcode==3231
	replace crop_type="Tree" if cropcode==3230
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2200
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1110
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1111
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1112
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2190
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2193
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2191
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2192
	replace crop_type="Tree-like plants" if cropcode==2170
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2160
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2150
	replace crop_type="Small trees or shrubs" if cropcode==3220
	replace crop_type="Tree" if cropcode==3210
	replace crop_type="Tree" if cropcode==3184
	replace crop_type="Tree" if cropcode==3170
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2130
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2120
	replace crop_type="Tree" if cropcode==3180
	replace crop_type="Tree" if cropcode==3183
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==3200
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1100
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1090
	replace crop_type="Tree" if cropcode==3160
	replace crop_type="Tree" if cropcode==3150
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1080
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1081
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1082
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1083
	replace crop_type="Tree" if cropcode==3140
	replace crop_type="Small trees or shrubs" if cropcode==3130
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2071
	replace crop_type="Small trees or shrubs" if cropcode==3120
	replace crop_type="Tree" if cropcode==3111
	replace crop_type="Tree" if cropcode==3112
	replace crop_type="Tree" if cropcode==3110
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==3100
	replace crop_type="Small trees or shrubs" if cropcode==3260
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2180
	replace crop_type="Small trees or shrubs" if cropcode==2110
	replace crop_type="Tree" if cropcode==3090
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1060
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2194
	replace crop_type="Tree" if cropcode==3080
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2102
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2101
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2100
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2090
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==3182
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==3250
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2080
	replace crop_type="Tree" if cropcode==2195
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==3070
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2060
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1053
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1052
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1050
	replace crop_type="Small trees or shrubs" if cropcode==3060
	replace crop_type="Small trees or shrubs" if cropcode==3061
	replace crop_type="Small trees or shrubs" if cropcode==3062
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1040
	replace crop_type="Tree" if cropcode==3050
	replace crop_type="Tree" if cropcode==3041
	replace crop_type="Tree" if cropcode==3042
	replace crop_type="Tree" if cropcode==3040
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==3030
	replace crop_type="Tree" if cropcode==3240
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1020
	replace crop_type="Tree" if cropcode==3022
	replace crop_type="Tree" if cropcode==3021
	replace crop_type="Tree" if cropcode==3020
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2050
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2070
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==3181
	replace crop_type="Small trees or shrubs" if cropcode==2140
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==3113
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2040
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==1010
	replace crop_type="Tree-like plants" if cropcode==2030
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2020
	replace crop_type="Tree" if cropcode==3221
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2143
	replace crop_type="Tree" if cropcode==3010
	replace crop_type="Tree" if cropcode==3190
	replace crop_type="Plant/Herb/Grass/Roots" if cropcode==2010

*--- Tree Classification - Initial 

	gen tree_type=""
	
	replace tree_type="Tree Crops" if cropcode==1124
replace tree_type="Tree Crops" if cropcode==2210
replace tree_type="Tree Crops" if cropcode==3232
replace tree_type="Tree Crops" if cropcode==3231
replace tree_type="Tree Crops" if cropcode==3230
replace tree_type="Tree Crops" if cropcode==3184
replace tree_type="Tree Crops" if cropcode==3180
replace tree_type="Tree Crops" if cropcode==3183
replace tree_type="Tree Crops" if cropcode==3140
replace tree_type="Tree Crops" if cropcode==2195
replace tree_type="Tree Crops" if cropcode==3041
replace tree_type="Tree Crops" if cropcode==3042
replace tree_type="Tree Crops" if cropcode==3040
replace tree_type="Tree Crops" if cropcode==3022
replace tree_type="Tree Crops" if cropcode==3021
replace tree_type="Tree Crops" if cropcode==3020
replace tree_type="Fruit Tree" if cropcode==2270
replace tree_type="Fruit Tree" if cropcode==3210
replace tree_type="Fruit Tree" if cropcode==3170
replace tree_type="Fruit Tree" if cropcode==3160
replace tree_type="Fruit Tree" if cropcode==3150
replace tree_type="Fruit Tree" if cropcode==3111
replace tree_type="Fruit Tree" if cropcode==3112
replace tree_type="Fruit Tree" if cropcode==3110
replace tree_type="Fruit Tree" if cropcode==3090
replace tree_type="Fruit Tree" if cropcode==3080
replace tree_type="Fruit Tree" if cropcode==3050
replace tree_type="Fruit Tree" if cropcode==3240
replace tree_type="Fruit Tree" if cropcode==3221
replace tree_type="Fruit Tree" if cropcode==3010
replace tree_type="Fruit Tree" if cropcode==3190
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1093
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2291
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2290
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1122
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1120
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1121
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2280
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1123
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1091
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1061
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2260
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2250
replace tree_type="Tree Crops" if cropcode==2240
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2181
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2141
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2230
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2220
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1070
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2142
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1092
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1062
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1051
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2200
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1110
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1111
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1112
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2190
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2193
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2191
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2192
replace tree_type="Tree Crops" if cropcode==2170
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2160
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2150
replace tree_type="Fruit Tree" if cropcode==3220
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2130
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2120
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==3200
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1100
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1090
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1080
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1081
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1082
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1083
replace tree_type="Fruit Tree" if cropcode==3130
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2071
replace tree_type="Fruit Tree" if cropcode==3120
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==3100
replace tree_type="Tree Crops" if cropcode==3260
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2180
replace tree_type="Tree Crops" if cropcode==2110
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1060
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2194
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2102
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2101
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2100
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2090
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==3182
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==3250
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2080
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==3070
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2060
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1053
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1052
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1050
replace tree_type="Tree Crops" if cropcode==3060
replace tree_type="Tree Crops" if cropcode==3061
replace tree_type="Tree Crops" if cropcode==3062
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1040
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==3030
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1020
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2050
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2070
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==3181
replace tree_type="Tree Crops" if cropcode==2140
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==3113
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2040
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==1010
replace tree_type="Fruit Tree" if cropcode==2030
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2020
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2143
replace tree_type="Plant/Herb/Grass/Roots" if cropcode==2010


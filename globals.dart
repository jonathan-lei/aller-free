library allerfree.globals;

//import 'dart:html';


//START TEMPORARY
String analyzedText = '';
String selectedUser = 'Grandma';
List<String> users = ['Grandma', 'Jonathan'];

List<String> allergenList = [];
List<String> allergenContainsList = [];
//END TEMPORARY

//START PROFILE
List<String> allergenChoiceList = [
  'PEANUT',
  'EGG',
  'SHELLFISH',
  'MILK',
  'TREE NUT',
  'WHEAT',
  'SOY',
  'SESAME'
];
var allergenChoices = {
  'PEANUT' :false,
  'EGG' : false,
  'SHELLFISH' : false,
  'MILK' : false,
  'TREE NUT' : false,
  'WHEAT' : false,
  'SOY' : false,
  'SESAME' : false,
};

//END PROFILE

//START DERIVATIVES
List<String> allergenDerivativeContainsList = [];
List<List<String>> allergenDerivativeList = [
  ['Peanut', 'Arachis', 'Artificial Nut', 'Beer Nut', 'Crushed Nut', 'Earth Nut', 'Goober', 'Ground Nut', 'Hypogaeic Acid', 'Mandelonas', 'Mixed Nut', 'Monkey Nut', 'Nu Nuts Flavored Nut', 'Nut Piece', 'Nutmeat'],
  ['Egg', 'Albumin', 'Apovitellin', 'Fat Substitutes', 'Globulin', 'Livetin', 'Lysozyme', 'Mayonnaise', 'Meringue', 'Meringue Powder', 'Ovalbumin', 'Ovogloblin', 'Ovomucin', 'Ovomucoid', 'Ovotransferrin', 'Ovovitelia', 'Ovovitellin', 'Silici Albuminate', 'Simplesse', 'Surimi', 'Trailblazer', 'Vitellin'],
  ['Shellfish', 'Barnacle', 'Crab', 'Crawfish', 'Crawdad', 'Crayfish', 'Ecrevisse', 'Krill', 'Lobster', 'Langouste', 'Langoustine', 'Moreton Bay Bug', 'Scampi', 'Tomalley', 'Prawns', 'Crevette', 'Shrimp'],
  ['Milk', 'Butter', 'Casein', 'Casinate', 'Cheese', 'Cream', 'Curd', 'Custard', 'Whey', 'Galactose', 'Ghee', 'Half & Half/Half And Half', 'Hydrolysates', 'Lactalbumin', 'Lactoglobulin', 'Lactose', 'Lactate', 'Lactyc', 'Lactic', 'Lactitol', 'Lactulose', 'Nougat', 'Paneer', 'Pudding', 'Recaldent', 'Dairy', 'Nisin Preparation', 'Quark', 'Rennet', 'Simplesse', 'Yogurt'],
  ['Tree Nut', 'Treenut', 'Almond', 'Walnut', 'Vitellaria Paradoxa', 'Shea Nut', 'Sheanut', 'Pralines', 'Prunus Dulcis', 'Pistachio', 'Pistacia Vera', 'Nut Paste', 'Nut Pieces', 'Nutmeat', 'Nut Oil', 'Nut Meal', 'Pili Nut', 'Pine Nut', 'Pinon', 'Pecan', 'Nut Butter', 'Mandelonas', 'Marzipan', 'Mashuga Nut', 'Nangai Nut', 'Bush Nut', 'Butternut', 'Artificial Nut', 'Beech Nut', 'Brazil Nut', 'Anacardium Nut', 'Chiquapin', 'Coconut', 'Chestnut', 'Cashew', 'Gianduja', 'Ginko Nut', 'Hazelnut', 'Heartnut', 'Hickory Nut', 'Indian Nut', 'Lichee Nut', 'Caponata', 'Filbert', 'Karite', 'Lychee Nut', 'Macadamia Nut', 'Nougat'],
  ['Wheat', 'Bread', 'Bulgur', 'Cereal Extract', 'Couscous', 'Cracker Meal', 'Einkorn', 'Emmer', 'Farro', 'Farina', 'Flour', 'Gluten', 'Fu', 'Khorasan', 'Malt', 'Matzo', 'Matzoh', 'Matzah', 'Matza', 'Noodles', 'Seitan', 'Semolina', 'Spelt', 'Tabbouleh', 'Triticale', 'Triticum', 'Starch'],
  ['Soy', 'Shoyu', 'Miso', 'Natto', 'Bean Curd', 'Edamame', 'Kinnoko Flour', 'Kyodofu', 'Okara', 'Soya', 'Soybean', 'Supro', 'Tamari', 'Tempeh', 'Teriyaki Sauce', 'TVP', 'TSF', 'TSP', 'Textured Vegetable Protein', 'Tofu', 'Yakidofu', 'Yuba'],
  ['Sesame', 'Benne', 'Benniseed', 'Gingelly', 'Gomasio', 'Halvah', 'Sesamol', 'Sesamum Indicum', 'Sesemolina', 'Sim sim', 'Tehina', 'Tahina', 'Tahini', 'Til'],
];

//END DERIVATIVES

//DEMO
List<String> allergenChoiceListProfile2 = [
  'PEANUT',
  'EGG',
  'SHELLFISH',
  'MILK',
  'TREE NUT',
  'WHEAT',
  'SOY',
  'SESAME'
];
var allergenChoicesProfile2 = {
  'PEANUT' :false,
  'EGG' : false,
  'SHELLFISH' : true,
  'MILK' : true,
  'TREE NUT' : true,
  'WHEAT' : false,
  'SOY' : false,
  'SESAME' : true,
};

import "bootstrap";

import { selectIngredients } from '../components/selectingredients';
import { selectKcal } from '../components/selectkcal';
import { selectDietType } from '../components/selecttype';
import { selectAllergy } from '../components/selectallergy';
import { removeFryingPan } from '../components/loading-pan';
import { aisleDropdown, checkAsPurchased } from '../components/grocery-list';

let pans = document.querySelectorAll('.loading-pan');
if(pans[0]) {
  setInterval( removeFryingPan(), 3000 );
};

selectIngredients();
selectKcal();
selectDietType();
selectAllergy();

let aisles = document.querySelectorAll('.aisle')
if(aisles[0]) {
  aisleDropdown();
  checkAsPurchased();
};

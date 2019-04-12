import "bootstrap";

import { selectIngredients } from '../components/selectingredients';
import { selectKcal } from '../components/selectkcal';
import { selectDietType } from '../components/selecttype';
import { removeFryingPan } from '../components/loading-pan';

let pans = document.querySelectorAll('.loading-pan');
if(pans[0]) {
  setInterval( removeFryingPan(), 3000 );
};

selectIngredients();
selectKcal();
selectDietType();

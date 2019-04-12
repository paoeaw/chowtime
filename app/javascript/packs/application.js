import "bootstrap";

import { selectIngredients } from '../components/selectingredients';
import { removeFryingPan } from '../components/loading-pan';

selectIngredients();

let pans = document.querySelectorAll('.loading-pan');
if(pans[0]) {
  setInterval( removeFryingPan(), 3000 );
};

const aisleDropdown = () => {
  let aisles = document.querySelectorAll('.aisle')
  aisles = Array.prototype.slice.call(aisles)
  let lists = document.querySelectorAll('.ingr-list')
  aisles.forEach((aisle) => {
    aisle.addEventListener('click', (event) => {
      if(lists[aisles.indexOf(aisle)].classList.value.split(" ").includes('d-none')) {
        lists[aisles.indexOf(aisle)].classList.remove('d-none');
      } else {
        lists[aisles.indexOf(aisle)].classList.add('d-none');
      };
      i += 1;
    })
  })
}

const checkAsPurchased = () => {

}

export { aisleDropdown };

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
  let listItems = document.querySelectorAll('.list-item')
  listItems = Array.prototype.slice.call(listItems)
  let checkboxes = document.querySelectorAll('.form-check-input')
  listItems.forEach((item) => {
    item.addEventListener('click', (event) => {
      if(checkboxes[listItems.indexOf(item)].checked === true) {
        checkboxes[listItems.indexOf(item)].checked = false;
      } else {
        checkboxes[listItems.indexOf(item)].checked = true;
      };
    });
  });
}

export { aisleDropdown, checkAsPurchased };

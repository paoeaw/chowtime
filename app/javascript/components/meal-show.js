const checkDoseAsPurchased = (doses) => {
  doses.forEach((dose) => {
    dose.addEventListener('click', (event) => {
      const checkbox = document.querySelector(`#purchased_${dose.dataset['doseId']}`)
      if(dose.firstElementChild.classList.contains('checked')){
        dose.firstElementChild.outerHTML = "<i style='font-size: inherit;'class='far fa-circle text-dark'></i>";
        checkbox.checked = false;
      } else {
        dose.firstElementChild.outerHTML = "<i style='font-size: inherit;'class='far fa-check-circle checked'></i>";
        checkbox.checked = true;
      };
    })
  })
}

export { checkDoseAsPurchased }

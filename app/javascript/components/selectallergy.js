const selectAllergy = () => {
  const exclusion = document.querySelectorAll('.exclusion');
  const array = [];

  exclusion.forEach((item) => {
    item.addEventListener('click', (event) => {
      event.preventDefault();
      event.currentTarget.classList.toggle('active');
      const exclusionSearch = document.getElementById('meal_params_exclusions');
      const allergy = item.querySelector('#allergy').innerHTML.toLowerCase();
      if (array.includes(allergy)) {
        array.splice(array.indexOf(allergy), 1);
      }
      else {
        array.push(allergy);
      };
      exclusionSearch.value = array.join(',');
    });
  });
}

export { selectAllergy };

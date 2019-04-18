const selectAllergy = () => {
  const allergies = document.querySelectorAll('.allergies');
  const array = [];

  allergies.forEach((item) => {
    item.addEventListener('click', (event) => {
      event.preventDefault();
      event.currentTarget.classList.toggle('active');
      const allergySearch = document.getElementById('meal_params_exclusions');
      const allergy = item.querySelector('#allergy').innerHTML.toLowerCase();
      if (array.includes(allergy)) {
        array.splice(array.indexOf(allergy), 1);
      }
      else {
        array.push(allergy);
      };
      allergySearch.value = array.join(',');
    });
  });
}

export { selectAllergy };

const selectDietType = () => {
  const dietType = document.querySelectorAll('.type');

  dietType.forEach((item) => {
    item.addEventListener('click', (event) => {
      event.currentTarget.classList.toggle('active');
      const typeSearch = document.getElementById('meal_params_diet_type');
      const type = item.querySelector('#type-name');
      typeSearch.value = type.innerHTML;
    });
  });
}

export { selectDietType };

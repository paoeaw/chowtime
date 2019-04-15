const selectKcal = () => {
  const kcal = document.querySelectorAll('.kcal');

  kcal.forEach((item) => {
    item.addEventListener('click', (event) => {
      event.preventDefault();
      kcal.forEach((item) => item.classList.remove('active'));
      event.currentTarget.classList.add('active');
      const caloriesSearch = document.getElementById('meal_params_calories');
      const calories = item.querySelector('#calories');
      caloriesSearch.value = calories.innerHTML;
    });
  });
}

export { selectKcal };

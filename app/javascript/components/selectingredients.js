
const selectIngredients = () => {
  const ingredients = document.querySelectorAll('.list-item');

  const toggleActiveClass = (event) => {
    event.currentTarget.classList.toggle('active');
  };

  const toggleActiveOnClick = (ingredient) => {
    ingredient.addEventListener('click', toggleActiveClass);
  };

  ingredients.forEach(toggleActiveOnClick);
}

export { selectIngredients };

const addExclusion = () => {
  const other = document.querySelector('.exclusion');
  other.addEventListener('click', (event) => {
    event.preventDefault();
    event.currentTarget.classList.add('active');
    document.querySelector('.exclusion-form').style.display = 'block';
  });
}

export { addExclusion };

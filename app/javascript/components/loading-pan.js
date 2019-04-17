
  const removeFryingPan = () => {
    let pans = document.querySelectorAll('.loading-pan');
    let doses = document.querySelectorAll('.dose');
    let onLoadElements = document.querySelectorAll('.appear-on-load')
    if(doses.length > 0) {
      pans.forEach((pan) => {
        pan.style.display = 'none'
      });
      onLoadElements.forEach((element) => {
        element.classList.remove('d-none');
      });
    } else {
      console.log('no ingredients yet')
    }
  };


export { removeFryingPan };

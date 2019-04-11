
  const removeFryingPan = () => {
    let pans = document.querySelectorAll('.loading-pan');
    let doses = document.querySelectorAll('.dose');
    if(doses.length > 0) {
      pans.forEach((pan) => {
        pan.style.display = 'none'
      });
    } else {
      console.log('no ingredients yet')
    }
  };


export { removeFryingPan };

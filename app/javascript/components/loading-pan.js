
  const removeFryingPan = () => {
    // const pans = document.querySelectorAll('.loading-pan');
    let doses = document.querySelectorAll('.dose');
    if(doses.length > 0) {
      pans.forEach((pan) => {
        pan.style.display = 'none'
      });
    } else {
      // location.reload();
    }
  };


export { removeFryingPan };

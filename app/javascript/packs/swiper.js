var mySwiper = new Swiper('.swiper-container', {
  slidesPerView: 1, 
  navigation: {
    nextEl: '.swiper-button-next', 
    prevEl: '.swiper-button-prev', 
  },
  pagination: {
    el: '.swiper-pagination', 
    clickable: true, 
  },
});

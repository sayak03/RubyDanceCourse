document.addEventListener('DOMContentLoaded', () => {
    alert('hiiiiii');
    document.querySelectorAll('.like-toggle').forEach(button => {
      button.addEventListener('ajax:success', (event) => {
        const [data, status, xhr] = event.detail;
        const likeCount = button.querySelector('.like-count');
        const likeIcon = button.querySelector('i');
  
        if (data.liked) {
          likeIcon.classList.remove('far');
          likeIcon.classList.add('fas');
          likeIcon.nextSibling.textContent = ' Unlike';
        } else {
          likeIcon.classList.remove('fas');
          likeIcon.classList.add('far');
          likeIcon.nextSibling.textContent = ' Like';
        }
        likeCount.textContent = data.like_count;
      });
    });
  });
  
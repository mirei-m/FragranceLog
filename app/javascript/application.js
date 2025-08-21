// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./chart"
import Rails from "@rails/ujs"
Rails.start()

// コメント非同期
function toggleComment(commentId) {
  const shortVersion = document.getElementById(`comment-body-${commentId}`);
  const fullVersion = document.getElementById(`comment-full-${commentId}`);

  if (shortVersion && fullVersion) {
    if (shortVersion.style.display === 'none') {
      shortVersion.style.display = 'block';
      fullVersion.style.display = 'none';
    } else {
      shortVersion.style.display = 'none';
      fullVersion.style.display = 'block';
    }
  }
}

// ハンバーガーメニュー
function toggleMenu() {
  const menu = document.getElementById('mobile-menu');
  if (menu) {
    menu.classList.toggle('hidden');

    if (menu.classList.contains('hidden')) {
      document.body.style.overflow = '';
    } else {
      document.body.style.overflow = 'hidden';
    }
  }
}

// メニュー外クリックで閉じる
document.addEventListener('DOMContentLoaded', function() {
  document.addEventListener('click', function(event) {
    const menu = document.getElementById('mobile-menu');
    const menuButton = event.target.closest('button[onclick="toggleMenu()"]');

    if (menu && !menu.classList.contains('hidden') && !menuButton && !menu.contains(event.target)) {
      menu.classList.add('hidden');
      document.body.style.overflow = '';
    }
  });
});


window.toggleComment = toggleComment;
window.toggleMenu = toggleMenu;

// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./chart"
import Rails from "@rails/ujs"
Rails.start()

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

window.toggleComment = toggleComment;

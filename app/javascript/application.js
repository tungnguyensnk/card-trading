// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

Turbo.session.drive = false

document.addEventListener('DOMContentLoaded', () => {
  console.log('DOMContentLoaded event fired');
  setTimeout(() => {
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(alert => {
      const bsAlert = new bootstrap.Alert(alert);
      bsAlert.close();
    });
  }, 5000); // 5000 milliseconds = 5 seconds
});

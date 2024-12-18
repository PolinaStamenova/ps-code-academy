import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  async submit(event) {
    event.preventDefault();
  
    const form = event.target.closest("form");
    const response = await fetch(form.action, {
      method: form.method,
      headers: { "Accept": "text/html" },
      body: new FormData(form),
    });
  
    if (response.redirected) {
      window.location.href = response.url;
    } else if (response.ok) {
      const modal = document.getElementById("modal");
      if (modal) modal.innerHTML = "";
    } else {
      const errorHTML = await response.text();
      const modal = document.getElementById("modal");
      if (modal) modal.innerHTML = errorHTML;
    }
  }  
}

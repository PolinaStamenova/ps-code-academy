import { Controller } from "@hotwired/stimulus" 

export default class extends Controller {
  connect() {
    console.log("Modal connected");

    // Add blade screen
    const screen_blade = document.getElementById('screenBlade');
    screen_blade.classList.remove('hidden');
    screen_blade.classList.add('active');
  }
  
  close(e) {
    e.preventDefault();

    const modal = document.getElementById('modal');
    modal.innerHTML = '';

    modal.removeAttribute('src');
    modal.removeAttribute('completed');

    // Remove blade screen
    const screen_blade = document.getElementById('screenBlade');
    screen_blade.classList.remove('active');
    screen_blade.classList.add('hidden');
  }
}
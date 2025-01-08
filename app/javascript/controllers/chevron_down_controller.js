import { Controller } from "@hotwired/stimulus" 

export default class extends Controller {
  static targets = ["list", "chevron"];

  connect() {
    console.log("Chevron-down controller connected");
  }
  
  chevron() {    
    const list = this.listTarget;
    const chevron = this.chevronTarget;

    if (list.classList.contains("hidden")) {
      this.openList(list, chevron);
    }
    else {
      this.closeList(list, chevron);
    }
  }

  openList(list, chevron) {
    list.classList.remove("hidden");
    chevron.classList.remove("fa-chevron-down");
    chevron.classList.add("fa-chevron-up");
  }

  closeList(list, chevron) {
    list.classList.add("hidden");
    chevron.classList.remove("fa-chevron-up");
    chevron.classList.add("fa-chevron-down");
  }
}
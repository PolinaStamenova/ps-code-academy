import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "label", "video"];

  connect() {
    const input = this.inputTarget;
    
    input.addEventListener("change", (event) => this.showPreview(event));
  }

  showPreview(event) {
    const file = event.target.files[0];

    if (file) {
      // Create a URL for the file
      const fileURL = URL.createObjectURL(file);
      const video_preview = this.videoTarget

      video_preview.src = fileURL;
      this.showElement(video_preview)

      // Show video preview remove button
      const remove_preview_button = document.getElementById("removePreview");
      this.showElement(remove_preview_button)

      // Hide upload video label (input)
      this.hideElement(this.labelTarget)
    }
  }

  remove() {    
    // Hide video preview remove button
    const remove_preview_button = document.getElementById("removePreview");
    this.hideElement(remove_preview_button)

    // Hide video preview section
    const video_preview = this.videoTarget
    this.hideElement(video_preview)

    // Show upload video label (input)
    this.showElement(this.labelTarget)

    // Clear input value
    const input = this.inputTarget
    input.value = "";
  }

  showElement(element) {
    element.classList.remove("hidden");
  }

  hideElement(element) {
    element.classList.add("hidden");
  }
}

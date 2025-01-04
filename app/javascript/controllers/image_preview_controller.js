import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "label", "image"];

  connect() {
    const input = this.inputTarget;
    input.addEventListener("change", (event) => this.showPreview(event));
  }

  showPreview(event) {
    const file = event.target.files[0];

    if (file) {
      // Create a URL for the file
      const fileURL = URL.createObjectURL(file);
      const imagePreview = this.imageTarget;

      imagePreview.src = fileURL;
      this.showElement(imagePreview);

      // Show image preview remove button
      const removePreviewButton = document.getElementById("removePreview");
      this.showElement(removePreviewButton);

      // Hide upload image label (input)
      this.hideElement(this.labelTarget);
    }
  }

  remove() {
    // Hide image preview remove button
    const removePreviewButton = document.getElementById("removePreview");
    this.hideElement(removePreviewButton);

    // Hide image preview section
    const imagePreview = this.imageTarget;
    this.hideElement(imagePreview);

    // Show upload image label (input)
    this.showElement(this.labelTarget);

    // Clear input value
    const input = this.inputTarget;
    input.value = "";
  }

  showElement(element) {
    element.classList.remove("hidden");
  }

  hideElement(element) {
    element.classList.add("hidden");
  }
}

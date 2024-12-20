import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "label", "preview"];

  connect() {
    this.inputTarget.addEventListener("change", (event) => this.showPreviews(event));

    // Listen for direct upload completion
    document.addEventListener("direct-upload:end", (event) => this.handleDirectUploadEnd(event));
  }

  showPreviews(event) {
    const files = event.target.files;
    
    Array.from(files).forEach((file) => {      
      const filePreviewContainer = document.createElement("div");
      filePreviewContainer.classList.add("flex", "justify-between", "items-center", "w-full");

      // Add span element with the file name
      const fileName = document.createElement("span");
      fileName.classList.add("text-xs");
      fileName.textContent = file.name;
      filePreviewContainer.appendChild(fileName);

      // Add remove file Text with Icon
      const removeContainer = document.createElement("div");
      removeContainer.classList.add("p-2", "flex", "gap-2", "items-center", "justify-end", "bg-transparent", "border-1", "border-gray-400", "rounded-3xl", "cursor-pointer" ,"hover:bg-red-600", "transition");

      const removeIcon = document.createElement("i");
      removeIcon.classList.add("fa-solid", "fa-xmark", "text-xs");

      const removeText = document.createElement("p");
      removeText.classList.add("text-xs");
      removeText.textContent = "Remove";

      removeContainer.appendChild(removeIcon);
      removeContainer.appendChild(removeText);
      
      filePreviewContainer.appendChild(removeContainer);

      removeContainer.addEventListener("click", () => this.removeFile(filePreviewContainer, file.name));

      // Append the preview to the preview container
      this.previewTarget.appendChild(filePreviewContainer);

      // Show the preview container
      this.showElement(this.previewTarget);
    });
  }

  handleDirectUploadEnd(event) {
    const { target } = event;

    if (target === this.inputTarget) {
      // Get the signed ID of the uploaded file from the dataset
      const signedId = target.dataset.directUploadId;
      const signedIdInput = document.createElement("input");
      signedIdInput.type = "hidden";
      signedIdInput.name = "file_signed_ids[]"; // Ensure Rails can handle multiple IDs
      signedIdInput.value = signedId;
    }
  }

  removeFile(filePreviewContainer, fileName) {
    // Remove the file preview
    this.previewTarget.removeChild(filePreviewContainer);
    
    // If there are no more previews (uploaded files div childs) but only "Uploaded Files:" child, hide the preview container
    if (this.previewTarget.children.length === 1) {
      this.hideElement(this.previewTarget);
    }
  }

  showElement(element) {
    element.classList.remove("hidden");
  }

  hideElement(element) {
    element.classList.add("hidden");
  }
}

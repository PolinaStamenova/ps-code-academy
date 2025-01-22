import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { deletionPath: String };

  closeDelete() {      
    fetch(this.deletionPathValue, {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
    })
      .then((response) => {
        if (response.ok) {
          // Check if the response is a redirect
          const redirectUrl = response.headers.get("Location");
          if (redirectUrl) {
            window.location.href = redirectUrl;
          } else {
            console.log("Record deleted successfully");
          }
        } else {
          console.error("Failed to delete record");
        }
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }
}
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["sidebar", "dropdown"];

    connect() {
        // Add click event listener to the document
        document.addEventListener("click", this.handleClickOutside.bind(this));
    }

    disconnect() {
        // Remove click event listener when controller is disconnected
        document.removeEventListener("click", this.handleClickOutside.bind(this));
    }

    toggle() {
        this.sidebarTarget.classList.toggle("hidden");
    }

    close() {
        this.sidebarTarget.classList.add("hidden");
    }

    open() {
        this.sidebarTarget.classList.remove("hidden");
    }

    toggleDropdown(event) {
        event.stopPropagation();
        const dropdown = event.currentTarget.nextElementSibling;
        dropdown.classList.toggle("hidden");
    }

    handleClickOutside(event) {
        // Close dropdown if clicking outside
        if (!event.target.closest("#user-menu-button")) {
            const dropdown = document.querySelector("[role='menu']");
            if (dropdown && !dropdown.classList.contains("hidden")) {
                dropdown.classList.add("hidden");
            }
        }
    }
}

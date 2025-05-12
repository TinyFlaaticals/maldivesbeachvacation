// Room details toggle functionality
document.addEventListener("DOMContentLoaded", function() {
  const roomDetailsToggles = document.querySelectorAll(".room-details-toggle");
  
  roomDetailsToggles.forEach(toggle => {
    toggle.addEventListener("click", function() {
      const roomId = this.getAttribute("data-room-id");
      const detailsPanel = document.getElementById(`room-details-${roomId}`);
      
      if (detailsPanel) {
        // Toggle the hidden class
        detailsPanel.classList.toggle("hidden");
        
        // Change button text based on state
        if (detailsPanel.classList.contains("hidden")) {
          this.textContent = "Room Details";
        } else {
          this.textContent = "Hide Details";
        }
      }
    });
  });
}); 
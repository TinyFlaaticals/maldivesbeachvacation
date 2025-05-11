import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="filter"
export default class extends Controller {
  connect() {}

  setPriceRange() {
    const priceRange = document.querySelector(
      'input[name="price_range"]:checked'
    );
    if (priceRange) {
      const minPrice = document.querySelector('input[name="min_price"]');
      const maxPrice = document.querySelector('input[name="max_price"]');

      const params = new URLSearchParams();

      if (priceRange.value === "all") {
        minPrice.value = "";
        maxPrice.value = "";
        params.delete("min_price");
        params.delete("max_price");
      } else {
        const [min, max] = priceRange.value.split("-");
        minPrice.value = min;
        maxPrice.value = max;
        params.append("min_price", min);
        params.append("max_price", max);
      }

      this.submit();
    }
  }

  toggleFilters() {
    const filterContent = document.querySelector(
      '[data-filter-target="filterContent"]'
    );
    filterContent.classList.toggle("hidden");
  }

  submit() {
    const offer = document.querySelector('input[name="with_offer"]:checked');
    const discount = document.querySelector(
      'input[name="with_discount"]:checked'
    );

    // Get all checked facilities
    const facilityCheckboxes = document.querySelectorAll(
      'input[name="filter[facilities][]"]:checked'
    );
    const facilityIds = Array.from(facilityCheckboxes).map((cb) => cb.value);

    // Get all checked activities
    const activityCheckboxes = document.querySelectorAll(
      'input[name="filter[activities][]"]:checked'
    );
    const activityIds = Array.from(activityCheckboxes).map((cb) => cb.value);

    // Get all checked popular filters
    const filterCheckboxes = document.querySelectorAll(
      'input[name="filter[popular_filters][]"]:checked'
    );
    const filterIds = Array.from(filterCheckboxes).map((cb) => cb.value);

    // Get price range values
    const minPrice = document.querySelector('input[name="min_price"]');
    const maxPrice = document.querySelector('input[name="max_price"]');

    const minPriceValue = minPrice.value;
    const maxPriceValue = maxPrice.value;

    // Build query params
    const params = new URLSearchParams();

    if (offer) {
      params.append("with_offer", "true");
    }

    if (discount) {
      params.append("with_discount", "true");
    }

    if (facilityIds.length > 0) {
      facilityIds.forEach((id) => params.append("facilities[]", id));
    }

    if (activityIds.length > 0) {
      activityIds.forEach((id) => params.append("activities[]", id));
    }

    if (filterIds.length > 0) {
      filterIds.forEach((id) => params.append("popular_filters[]", id));
    }

    if (minPriceValue) {
      params.append("min_price", minPriceValue);
    }

    if (maxPriceValue) {
      params.append("max_price", maxPriceValue);
    }

    // Redirect with filters
    window.location.search = params.toString();
  }
}

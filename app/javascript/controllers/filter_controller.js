import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["filterContent", "toggleIcon", "searchInput"]

  connect() {
    // Set up search input handler - more robust selector
    const searchInput = document.querySelector('input[name="search"]') || 
                       document.querySelector('input[placeholder*="Beach westpalm"]');
    
    if (searchInput) {
      let searchTimeout;
      searchInput.addEventListener('input', (e) => {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => {
          this.submitSearch(e.target.value);
        }, 500); // Debounce search for 500ms
      });
    }

    // Set up sort handler
    const sortSelect = document.querySelector('#sort-by');
    if (sortSelect) {
      sortSelect.addEventListener('change', (e) => {
        this.submitSort(e.target.value);
      });
    }
  }

  setPriceRange(event) {
    const priceRangeCheckbox = event.target;
    
    if (priceRangeCheckbox.checked) {
      // Uncheck other price range checkboxes
      const otherCheckboxes = document.querySelectorAll('input[name^="price_range_"]:not([name="' + priceRangeCheckbox.name + '"])');
      otherCheckboxes.forEach(cb => cb.checked = false);
      
      // Extract min and max from checkbox name
      const match = priceRangeCheckbox.name.match(/price_range_(\d+)_(\d+)/);
      if (match) {
        const min = match[1];
        const max = match[2];
        
        // Set the manual input fields
        const minPriceInput = document.querySelector('input[name="min_price"]');
        const maxPriceInput = document.querySelector('input[name="max_price"]');
        
        if (minPriceInput) minPriceInput.value = min;
        if (maxPriceInput) maxPriceInput.value = max;
      }
    }
    
    this.submit();
  }

  submitSearch(searchTerm) {
    const params = this.getCurrentParams();
    
    if (searchTerm && searchTerm.trim() !== '') {
      params.set('search', searchTerm.trim());
    } else {
      params.delete('search');
    }
    
    window.location.search = params.toString();
  }

  submitSort(sortValue) {
    const params = this.getCurrentParams();
    
    // Map display text to controller values
    const sortMapping = {
      'Recommended': '',
      'Price: low to high': 'price_low', 
      'Price: high to low': 'price_high',
      'Rating': 'rating',
      'Name': 'name'
    };
    
    const sortParam = sortMapping[sortValue];
    if (sortParam) {
      params.set('sort', sortParam);
    } else {
      params.delete('sort');
    }
    
    window.location.search = params.toString();
  }

  toggleFilters() {
    const filterContent = this.filterContentTarget;
    const toggleIcon = this.toggleIconTarget;
    
    filterContent.classList.toggle("hidden");
    
    // Rotate the icon
    if (filterContent.classList.contains("hidden")) {
      toggleIcon.style.transform = "rotate(0deg)";
    } else {
      toggleIcon.style.transform = "rotate(180deg)";
    }
  }

  submit() {
    const params = this.getCurrentParams();

    // Handle special offers and discounts
    const offer = document.querySelector('input[name="with_offer"]:checked');
    const discount = document.querySelector('input[name="with_discount"]:checked');

    if (offer) {
      params.set("with_offer", "true");
    } else {
      params.delete("with_offer");
    }

    if (discount) {
      params.set("with_discount", "true");
    } else {
      params.delete("with_discount");
    }

    // Handle price range from checkboxes or manual inputs
    const priceRangeChecked = document.querySelector('input[name^="price_range_"]:checked');
    if (priceRangeChecked) {
      const match = priceRangeChecked.name.match(/price_range_(\d+)_(\d+)/);
      if (match) {
        params.set("price_range", `${match[1]}-${match[2]}`);
      }
    } else {
      params.delete("price_range");
      
      // Handle manual price inputs
      const minPrice = document.querySelector('input[name="min_price"]');
      const maxPrice = document.querySelector('input[name="max_price"]');

      if (minPrice && minPrice.value) {
        params.set("min_price", minPrice.value);
      } else {
        params.delete("min_price");
      }

      if (maxPrice && maxPrice.value) {
        params.set("max_price", maxPrice.value);
      } else {
        params.delete("max_price");
      }
    }

    // Handle multi-select filters
    this.handleMultiSelectFilter(params, 'filter[facilities][]', 'facilities[]');
    this.handleMultiSelectFilter(params, 'filter[activities][]', 'activities[]');
    this.handleMultiSelectFilter(params, 'filter[popular_filters][]', 'popular_filters[]');

    // Redirect with filters
    window.location.search = params.toString();
  }

  handleMultiSelectFilter(params, inputName, paramName) {
    const checkboxes = document.querySelectorAll(`input[name="${inputName}"]:checked`);
    const values = Array.from(checkboxes).map(cb => cb.value);
    
    // Remove existing params of this type
    const paramKey = paramName.replace('[]', '');
    const existingParams = Array.from(params.keys()).filter(key => key.startsWith(paramKey));
    existingParams.forEach(key => params.delete(key));
    
    // Add new params
    if (values.length > 0) {
      values.forEach(value => params.append(paramName, value));
    }
  }

  getCurrentParams() {
    const params = new URLSearchParams(window.location.search);
    return params;
  }
}

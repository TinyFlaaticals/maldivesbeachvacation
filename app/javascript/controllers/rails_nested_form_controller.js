import { Controller } from "@hotwired/stimulus";
import NestedForm from "@stimulus-components/rails-nested-form";

// Connects to data-controller="rails-nested-form"
export default class extends NestedForm {
  connect() {
    super.connect();
    console.log("Connected");
  }
}

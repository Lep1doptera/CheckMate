import { Controller } from "@hotwired/stimulus"
import EmblaCarousel from "embla-carousel"

export default class extends Controller {
  static targets = ["viewport", "prevBtn", "nextBtn"]

  connect() {
    this.embla = EmblaCarousel(this.viewportTarget)

    this.prevBtnTarget.addEventListener("click", () => this.embla.scrollPrev())
    this.nextBtnTarget.addEventListener("click", () => this.embla.scrollNext())
  }
}

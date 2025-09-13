import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auto-complete"
export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    console.log("AutoCompleteが接続されました")
    this.resultsTarget.hidden = true

    this.inputTarget.addEventListener("input", this.search.bind(this))
    this.inputTarget.addEventListener("focus", this.search.bind(this))
    document.addEventListener("click", this.hideResults.bind(this))
  }

  hideResults(event) {
    if (!this.element.contains(event.target)) {
      this.resultsTarget.hidden = true
    }
  }

  async search() {
    const query = this.inputTarget.value.trim()
    if (query.length < 2) {
      this.resultsTarget.hidden = true
      return
    }

    try {
      const response = await fetch(`/reviews/autocomplete?term=${encodeURIComponent(query)}`)
      const data = await response.json()

      this.resultsTarget.innerHTML = ""

      if (data.length > 0) {
        this.resultsTarget.hidden = false

        data.forEach(item => {
          const element = document.createElement("div")
          element.classList.add("p-2", "hover:bg-gray-100", "cursor-pointer")

          element.dataset.id = item.id
          element.addEventListener("click", () => this.selectResult(item))
          this.resultsTarget.appendChild(element)
        })
      } else {
        this.resultsTarget.hidden = true
      }
    } catch (error) {
      console.error("オートコンプリートエラー:", error)
    }
  }

  selectResult(item) {
    this.inputTarget.value = item.value
    this.resultsTarget.hidden = true
  }
}
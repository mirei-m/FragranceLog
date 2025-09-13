import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auto-complete"
export default class extends Controller {
  static targets = ["input", "results"]
  static values = { url: String }

  connect() {
    console.log("AutoCompleteが接続されました")
    this.resultsTarget.classList.add('hidden')
    this.timeout = null
    this.selectedIndex = -1

    document.addEventListener("click", this.hideResults.bind(this))
  }

  disconnect() {
    document.removeEventListener("click", this.hideResults.bind(this))
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }

  handleInput() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.search()
    }, 300)
  }

  async search() {
    const query = this.inputTarget.value.trim()
    if (query.length < 2) {
      this.resultsTarget.classList.add('hidden')
      return
    }

    try {
      const url = `${this.urlValue}?term=${encodeURIComponent(query)}`
      const response = await fetch(url)
      const data = await response.json()

      this.displayResults(data)
    } catch (error) {
      console.error("オートコンプリートエラー:", error)
      this.resultsTarget.classList.add('hidden')
    }
  }

  displayResults(data) {
    this.resultsTarget.innerHTML = ""
    this.selectedIndex = -1

    if (data.length > 0) {
      this.resultsTarget.classList.remove('hidden')

      data.forEach((item, index) => {
        const element = document.createElement("div")
        element.classList.add(
          "autocomplete-item",
          "px-4",
          "py-2",
          "border-b",
          "border-gray-200",
          "cursor-pointer",
          "hover:bg-gray-50",
          "transition-colors",
          "duration-150"
        )

        element.innerHTML = `
          <div class="font-semibold text-gray-800">${this.escapeHtml(item.brand_name)}</div>
          <div class="text-sm text-gray-600">${this.escapeHtml(item.perfume_name)}</div>
        `

        element.dataset.index = index
        element.addEventListener("click", () => this.selectResult(item))
        element.addEventListener("mouseenter", () => {
          this.selectedIndex = index
          this.updateSelection()
        })

        this.resultsTarget.appendChild(element)
      })
    } else {
      const noResultElement = document.createElement("div")
      noResultElement.classList.add("p-4", "text-gray-500", "text-center", "text-sm")
      noResultElement.textContent = "該当する香水が見つかりませんでした"
      this.resultsTarget.appendChild(noResultElement)
      this.resultsTarget.classList.remove('hidden')
    }
  }

  selectResult(item) {
    this.inputTarget.value = item.value
    this.resultsTarget.classList.add('hidden')
    this.inputTarget.focus()
  }

  hideResults(event) {
    if (!this.element.contains(event.target)) {
      this.resultsTarget.classList.add('hidden')
      this.selectedIndex = -1
    }
  }

  handleKeydown(event) {
    const items = this.resultsTarget.querySelectorAll('.autocomplete-item')

    if (items.length === 0) return

    switch (event.key) {
      case 'ArrowDown':
        event.preventDefault()
        this.selectedIndex = Math.min(this.selectedIndex + 1, items.length - 1)
        this.updateSelection()
        break

      case 'ArrowUp':
        event.preventDefault()
        this.selectedIndex = Math.max(this.selectedIndex - 1, -1)
        this.updateSelection()
        break

      case 'Enter':
        event.preventDefault()
        if (this.selectedIndex >= 0 && items[this.selectedIndex]) {
          const selectedItem = items[this.selectedIndex]
          const index = parseInt(selectedItem.dataset.index)

          const brand = selectedItem.querySelector('div:first-child').textContent
          const perfume = selectedItem.querySelector('div:last-child').textContent
          this.inputTarget.value = `${brand} ${perfume}`
          this.resultsTarget.classList.add('hidden')
        }
        break

      case 'Escape':
        this.resultsTarget.classList.add('hidden')
        this.selectedIndex = -1
        break
    }
  }

  updateSelection() {
    const items = this.resultsTarget.querySelectorAll('.autocomplete-item')

    items.forEach((item, index) => {
      if (index === this.selectedIndex) {
        item.classList.add('bg-gray-100')
      } else {
        item.classList.remove('bg-gray-100')
      }
    })
  }

  escapeHtml(text) {
    const div = document.createElement('div')
    div.textContent = text
    return div.innerHTML
  }
}

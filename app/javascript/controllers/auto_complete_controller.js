import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auto-complete"
export default class extends Controller {
  static targets = ["input", "results"]
  static values = { url: String, delay: { type: Number, default: 300 } }

  connect() {
    console.log("AutoCompleteが接続されました")
    this.resultsTarget.hidden = true
    this.timeout = null // デバウンス用のタイマー

    this.inputTarget.addEventListener("input", this.handleInput.bind(this))
    this.inputTarget.addEventListener("focus", this.handleInput.bind(this))
    document.addEventListener("click", this.hideResults.bind(this))
  }

  handleInput() {
    // 前回のタイマーをクリア
    clearTimeout(this.timeout)

    // 新しいタイマーを設定
    this.timeout = setTimeout(() => {
      this.search()
    }, this.delayValue)
  }

  async search() {
    const query = this.inputTarget.value.trim()
    if (query.length < 2) {
      this.resultsTarget.hidden = true
      return
    }

    try {
      const url = this.urlValue || `/reviews/autocomplete?term=${encodeURIComponent(query)}`
      const response = await fetch(url)
      const data = await response.json()

      this.displayResults(data)
    } catch (error) {
      console.error("オートコンプリートエラー:", error)
      this.resultsTarget.hidden = true
    }
  }

  displayResults(data) {
    this.resultsTarget.innerHTML = ""

    if (data.length > 0) {
      this.resultsTarget.hidden = false

      data.forEach(item => {
        const element = document.createElement("div")
        element.classList.add("autocomplete-item", "p-2", "hover:bg-gray-100", "cursor-pointer", "border-b")

        // 香水の場合はブランド名と商品名を分けて表示
        element.innerHTML = `
          <div class="font-medium">${item.brand_name}</div>
          <div class="text-sm text-gray-600">${item.perfume_name}</div>
        `

        element.dataset.id = item.id
        element.addEventListener("click", () => this.selectResult(item))
        this.resultsTarget.appendChild(element)
      })
    } else {
      // 検索結果がない場合
      const noResultElement = document.createElement("div")
      noResultElement.classList.add("p-2", "text-gray-500", "text-center")
      noResultElement.textContent = "該当する香水が見つかりませんでした"
      this.resultsTarget.appendChild(noResultElement)
      this.resultsTarget.hidden = false
    }
  }

  selectResult(item) {
    // ブランド名と香水名を組み合わせて表示
    this.inputTarget.value = `${item.brand_name} ${item.perfume_name}`
    this.resultsTarget.hidden = true

    this.inputTarget.focus()
  }
}
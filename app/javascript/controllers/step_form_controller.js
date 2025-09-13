import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step", "nextButton"]
  static values = { currentStep: Number, totalSteps: Number }

  connect() {
    this.currentStepValue = 1
    this.totalStepsValue = this.stepTargets.length
    this.showCurrentStep()
  }

  next() {
    if (this.canProceed() && this.currentStepValue < this.totalStepsValue) {
      this.currentStepValue++
      this.showCurrentStep()
    }
  }

  previous() {
    if (this.currentStepValue > 1) {
      this.currentStepValue--
      this.showCurrentStep()
    }
  }

  // 回答状況をチェックするメソッド（ラジオボタンの変更時に呼び出される）
  checkAnswer() {
    this.updateNextButtonState()
  }

  showCurrentStep() {
    this.stepTargets.forEach((step, index) => {
      if (index === this.currentStepValue - 1) {
        step.style.display = "block"
      } else {
        step.style.display = "none"
      }
    })
    this.updateProgressIndicator()
    this.updateProgressBar()
    this.updateNextButtonState()
  }

  // プログレスインジゲーターの数値更新
  updateProgressIndicator() {
    const indicator = this.element.querySelector('.progress-indicator')
    if (indicator) {
      indicator.textContent = `${this.currentStepValue}/${this.totalStepsValue}`
    }
  }

  // プログレスバーの更新
  updateProgressBar() {
    const progressBar = this.element.querySelector('.progress-bar')
    if (progressBar) {
      const percentage = (this.currentStepValue / this.totalStepsValue) * 100
      progressBar.style.width = `${percentage}%`
    }
  }

  // 現在のステップで回答が選択されているかチェック
  canProceed() {
    const currentStepElement = this.stepTargets[this.currentStepValue - 1]
    const radioButtons = currentStepElement.querySelectorAll('input[type="radio"]')
    return Array.from(radioButtons).some(radio => radio.checked)
  }

  // 進むボタンの有効/無効を切り替え
  updateNextButtonState() {
    const currentStepElement = this.stepTargets[this.currentStepValue - 1]
    const nextButton = currentStepElement.querySelector('[data-step-form-target="nextButton"]')

    if (nextButton) {
      if (this.canProceed()) {
        nextButton.disabled = false
        nextButton.classList.remove('btn-disabled', 'opacity-70', 'cursor-not-allowed')
        nextButton.classList.add('btn-primary')
      } else {
        nextButton.disabled = true
        nextButton.classList.add('btn-disabled', 'opacity-70', 'cursor-not-allowed')
        nextButton.classList.remove('btn-primary')
      }
    }
  }
}
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step"]
  static values = { currentStep: Number, totalSteps: Number }

  connect() {
    this.currentStepValue = 1
    this.totalStepsValue = this.stepTargets.length
    this.showCurrentStep()
  }

  next() {
    if (this.currentStepValue < this.totalStepsValue) {
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

  showCurrentStep() {
    this.stepTargets.forEach((step, index) => {
      if (index === this.currentStepValue - 1) {
        step.style.display = "block"
      } else {
        step.style.display = "none"
      }
    })
    this.updateProgressIndicator()
  }

  updateProgressIndicator() {
    const indicator = this.element.querySelector('.progress-indicator')
    if (indicator) {
      indicator.textContent = `${this.currentStepValue}/${this.totalStepsValue}`
    }
  }
}

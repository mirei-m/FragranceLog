class DiagnosesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create, :result ]

  def new
    @questions = Diagnosis::QUESTIONS
  end

  def create
    selected_answers = params[:answers] || {}

    # 全設問のキーを取得
    required_keys = Diagnosis::QUESTIONS.keys.map(&:to_s)

    # 未回答の設問があるかチェック
    missing_keys = required_keys.reject { |key| selected_answers.key?(key) && selected_answers[key].present? }

    if missing_keys.any?
      @questions = Diagnosis::QUESTIONS
      @selected_answers = selected_answers
      flash.now[:alert] = "全ての設問に回答してください。"
      render :new, status: :unprocessable_entity
      return
    end

    # すべて回答済みなら診断処理へ
    result_category = Diagnosis.diagnose(selected_answers)
    redirect_to result_diagnosis_path(category: result_category)
  end

  def result
    category_key = params[:category]&.to_sym

    if Diagnosis::CATEGORIES.key?(category_key)
      @result = Diagnosis.result_for(category_key)
    else
      redirect_to new_diagnosis_path, alert: "診断結果が見つかりませんでした。"
    end
  end
end

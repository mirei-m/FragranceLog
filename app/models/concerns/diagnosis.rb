module Diagnosis
  extend ActiveSupport::Concern

  CATEGORIES = {
    citrus: {
      name: "シトラス（Citrus）",
      description: "柑橘系の爽やかで、軽やかに気分をリフレッシュしてくれる香り。",
      image_path: "diagnosis/citrus.jpg",
      notes: [ "レモン", "オレンジ", "ベルガモット" ]
    },
    floral: {
      name: "フローラル（Floral）",
      description: "花束のように華やかで、やさしく包み込むような香り。",
      image_path: "diagnosis/floral.jpg",
      notes: [ "ローズ", "ジャスミン", "スズラン" ]
    },
    fruity: {
      name: "フルーティ（Fruity）",
      description: "みずみずしい果実の甘さが広がる、明るく親しみやすい香り。",
      image_path: "diagnosis/fruity.jpg",
      notes: [ "ピーチ", "アップル", "ベリー" ]
    },
    woody: {
      name: "ウッディ（Woody）",
      description: "木や森を思わせる落ち着いた香り。芯のある大人の雰囲気に。",
      image_path: "diagnosis/woody.jpg",
      notes: [ "サンダルウッド", "シダーウッド", "パチュリ" ]
    },
    spicy: {
      name: "スパイシー（Spicy）",
      description: "スパイスの効いたエッジのある香り。刺激的で個性を引き立てます。",
      image_path: "diagnosis/spicy.jpg",
      notes: [ "シナモン", "クローブ", "ブラックペッパー" ]
    },
    oriental: {
      name: "オリエンタル（Oriental）",
      description: "甘さと深みのあるエキゾチックな香り。魅惑的でミステリアス。",
      image_path: "diagnosis/oriental.jpg",
      notes: [ "バニラ", "アンバー", "ムスク" ]
    },
    marine: {
      name: "マリン（Marine）",
      description: "海風のようにすっきりとした清潔感ある香り。夏にもぴったり。",
      image_path: "diagnosis/marine.jpg",
      notes: [ "シーソルト", "アクアノート", "マリンノート" ]
    },
    green: {
      name: "グリーン（Green）",
      description: "草やハーブのような自然を感じる香り。すがすがしくナチュラル。",
      image_path: "diagnosis/green.jpg",
      notes: [ "グリーンティー", "バジル", "フィグリーフ" ]
    }
  }.freeze

  def self.result_for(category)
    CATEGORIES[category]
  end

  QUESTIONS = {
    q1: {
      question: "今日のあなたの気分に一番近いのは？",
      options: {
        "A" => { text: "やさしく穏やかに過ごしたい", categories: [ :floral, :green ] },
        "B" => { text: "楽しくワクワクしていたい", categories: [ :fruity, :citrus ] },
        "C" => { text: "なんとなく気分転換したい", categories: [ :spicy, :marine ] },
        "D" => { text: "落ち着いて冷静な気分", categories: [ :woody, :oriental ] }
      }
    },
    q2: {
      question: "今日のお出かけ先はどんなところ？",
      options: {
        "A" => { text: "家でリラックス", categories: [ :floral, :woody ] },
        "B" => { text: "自然のある場所やアウトドア", categories: [ :green, :citrus ] },
        "C" => { text: "仕事や学校など日常の場所", categories: [ :marine, :green ] },
        "D" => { text: "カフェや本屋", categories: [ :oriental, :fruity ] }
      }
    },
    q3: {
      question: "なりたい雰囲気は？",
      options: {
        "A" => { text: "清潔感があって爽やか", categories: [ :citrus, :marine ] },
        "B" => { text: "ミステリアスで個性的", categories: [ :oriental, :spicy ] },
        "C" => { text: "明るくて親しみやすい", categories: [ :floral, :fruity ] },
        "D" => { text: "自信があってカッコいい", categories: [ :woody, :spicy ] }
      }
    },
    q4: {
      question: "今の季節や天気は？",
      options: {
        "A" => { text: "暖かくて過ごしやすい", categories: [ :floral, :fruity ] },
        "B" => { text: "ちょっと肌寒い", categories: [ :woody, :oriental ] },
        "C" => { text: "雨や曇りでしっとり", categories: [ :spicy, :green ] },
        "D" => { text: "暑くて夏バテ気味", categories: [ :citrus, :marine ] }
      }
    }
  }.freeze

  # 回答（例: { q1: 'A', q2: 'C', q3: 'D', q4: 'B' }）を受け取って診断結果カテゴリを返す
  def self.diagnose(answers)
    score = Hash.new(0)

    answers.each do |question_key, selected_option|
      option_data = QUESTIONS[question_key.to_sym][:options][selected_option]
      next unless option_data

      option_data[:categories].each do |category|
        score[category] += 1
      end
    end

    max_score = score.values.max
    top_categories = score.select { |_, v| v == max_score }.keys
    top_categories.sample # 同点ならランダムに選択
  end
end

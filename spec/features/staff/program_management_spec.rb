require 'rails_helper'

feature 'プログラム管理機能', :performance do
  include FeaturesSpecHelper
  include PerformanceSpecHelper
  # オフジェクトを使用できるように記憶
  let(:staff_member) { create(:staff_member) }

# テスト前の準備
  before do
    20.times do |n|
      # プログラム２０件を作成
      p = create(:program, application_start_time: n.days.ago.midnight)
      if n < 2
        p.applicants << create(:customer)
        p.applicants << create(:customer)
      end
    end

    #ルーテング名前空間の切り替え
    switch_namespace(:staff)
    # スタッフとしてログイン
    login_as_staff_member(staff_member)
  end

  # 引数はエグザンプルオブジェクトがセットされる（メタデータなど）
  scenario 'プログラム一覧' do |example|
    # 特定ページの訪問（プログラム一覧）
    visit staff_programs_path
    # 表示内容が正しいか確認。
    # また一度呼び出しておくことで次のベンチマークテストで初回遅延影響を除く
    expect(page).to have_css('h1', text: 'プログラム管理')

    puts page.body

    # Benchmarkモジュールのrealtimeを使用しベンチマークテストの実行 = elapsedへ
    elapsed = Benchmark.realtime do
      # １００回繰り返す
      100.times do
        # 特定ページの訪問（プログラム一覧）
        visit staff_programs_path
      end
    end

    # 引数を持ってPerformanceSpecHelperで定義したメソッドでログ出力
    write_to_performance_log(example, elapsed)
    # ログの内容を評価 反応遅延時間のマッチャ 100秒以下ならパス
    expect(elapsed).to be < 100.0
  end
end

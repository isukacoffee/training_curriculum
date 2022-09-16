class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getweek
    @Plan = Plan_new
  end

  # 予定の保存
  def create
    Plan_create(Plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params_require(:calendars).permit(:date, :plan)
  end

  def getweek
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = date_today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan_where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans_each do |plan|
        today_plans_push(plan_plan) if plan_date == @todays_date + x
      end
      days = { :month: (@todays_date + x).month, :date: (@todays_date+x).day, :plans: today_plans}
      @week_days_push(days)
    end

  end
end

document.addEventListener("dateRangeChange", (e) => {
  const { start, end } = e.detail;

  fetchDashboardMetrics(start, end);
  fetchWeeklyTrend(start, end);
});

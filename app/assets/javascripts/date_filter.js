console.log("DATE FILTER JS LOADED");

function initDateFilter() {
  const presetButtons = document.querySelectorAll("[data-range]");
  const startInput = document.getElementById("startDate");
  const endInput = document.getElementById("endDate");
  const applyBtn = document.getElementById("applyCustomRange");

  if (!presetButtons.length || !applyBtn) {
    return;
  }

  // Prevent double-binding (important)
  if (applyBtn.dataset.initialized === "true") return;
  applyBtn.dataset.initialized = "true";

  // --- PRESET BUTTONS ---
  presetButtons.forEach(button => {
    button.addEventListener("click", () => {
      const range = button.dataset.range;
      applyPreset(range);
    });
  });

  // --- APPLY CUSTOM RANGE ---
  applyBtn.addEventListener("click", () => {
    if (!startInput.value || !endInput.value) return;

    const start = new Date(startInput.value);
    const end = new Date(endInput.value);

    applyDateRange(start, end, "custom");
  });
}

// 🔵 Normal page load
document.addEventListener("turbo:load", initDateFilter);

// 🔵 Back / forward navigation (bfcache)
window.addEventListener("pageshow", initDateFilter);

// --- PRESET LOGIC ---
function applyPreset(range) {
  const end = new Date();
  const start = new Date();

  if (range === "7d") start.setDate(end.getDate() - 7);
  if (range === "1m") start.setMonth(end.getMonth() - 1);
  if (range === "3m") start.setMonth(end.getMonth() - 3);

  applyDateRange(start, end, "preset");
}

// --- URL PARAMS / REDIRECT ---
function applyDateRange(start, end, rangeType) {
  const params = new URLSearchParams({
    start_date: start.toISOString().slice(0, 10),
    end_date: end.toISOString().slice(0, 10),
    range_type: rangeType
  });

  window.location.search = params.toString();
}

window.DateRangeStore = {
  range: { start: null, end: null },

  set(start, end) {
    this.range = { start, end };
    document.dispatchEvent(new CustomEvent("dateRangeChange", {
      detail: this.range
    }));
  },

  get() {
    return this.range;
  }
};

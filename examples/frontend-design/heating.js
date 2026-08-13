/* Dummy Heating Assistant panel behaviour — calibration only. */

const SP_STEP = 0.5;
const SP_MIN = 5;
const SP_MAX = 30;
const OFFSET_STEP = 0.1;
const OFFSET_MIN = 0.1;
const OFFSET_MAX = 5;
const TRACK_HALF = 3;

const clampSp = (n) => Math.min(SP_MAX, Math.max(SP_MIN, Math.round(n * 2) / 2));
const clampOff = (n) => Math.min(OFFSET_MAX, Math.max(OFFSET_MIN, Math.round(n * 10) / 10));

function paintTrack(card) {
  const current = parseFloat(card.dataset.current);
  const target = parseFloat(card.dataset.target);
  const offset = parseFloat(card.dataset.offset);
  const comfort = card.querySelector(".climate-card__track-comfort");
  const marker = card.querySelector(".climate-card__track-marker");
  const minEl = card.querySelector(".climate-card__track-min");
  const maxEl = card.querySelector(".climate-card__track-max");
  const label = card.querySelector(".climate-card__track-comfort-label");
  const track = card.querySelector(".climate-card__track");
  if (!comfort || !marker) return;

  const half = Math.max(TRACK_HALF, offset + 0.75);
  const lo = target - half;
  const hi = target + half;
  const pct = (v) => Math.max(0, Math.min(100, ((v - lo) / (hi - lo)) * 100));
  const lower = target - offset;
  const upper = target + offset;

  comfort.style.left = pct(lower) + "%";
  comfort.style.width = Math.max(0, pct(upper) - pct(lower)) + "%";
  marker.style.left = pct(current) + "%";
  if (minEl) minEl.textContent = lo.toFixed(0) + "°";
  if (maxEl) maxEl.textContent = hi.toFixed(0) + "°";
  if (label) label.textContent = "Comfort " + lower.toFixed(1) + "–" + upper.toFixed(1) + "°";
  if (track) {
    track.setAttribute(
      "aria-label",
      "Comfort band " + lower.toFixed(1) + " to " + upper.toFixed(1) +
        " degrees. Current " + current.toFixed(1) + ", target " + target.toFixed(1) + "."
    );
  }
}

function paintCard(card) {
  const off = card.classList.contains("is-off");
  const target = parseFloat(card.dataset.target);
  const offset = parseFloat(card.dataset.offset);
  const targetEl = card.querySelector(".climate-card__target-value");
  const offsetEl = card.querySelector(".climate-card__offset-value");
  const status = card.querySelector(".climate-card__status");
  const down = card.querySelector(".climate-card__step--down");
  const up = card.querySelector(".climate-card__step--up");
  const oDown = card.querySelector(".climate-card__offset-step--down");
  const oUp = card.querySelector(".climate-card__offset-step--up");
  if (targetEl && !Number.isNaN(target)) targetEl.textContent = target.toFixed(1) + "°";
  if (offsetEl && !Number.isNaN(offset)) offsetEl.textContent = "±" + offset.toFixed(1) + "°";
  if (down) down.disabled = off || target <= SP_MIN;
  if (up) up.disabled = off || target >= SP_MAX;
  if (oDown) oDown.disabled = off || offset <= OFFSET_MIN;
  if (oUp) oUp.disabled = off || offset >= OFFSET_MAX;
  if (status && !card.classList.contains("is-experiment")) {
    status.textContent = off ? "Off" : (card.classList.contains("is-heating") ? "Heating" : "Idle");
  }
  if (!off && !card.classList.contains("is-experiment")) paintTrack(card);
}

function bindCard(card) {
  if (card.classList.contains("is-experiment")) return;
  const power = card.querySelector(".climate-card__power");
  const down = card.querySelector(".climate-card__step--down");
  const up = card.querySelector(".climate-card__step--up");
  const oDown = card.querySelector(".climate-card__offset-step--down");
  const oUp = card.querySelector(".climate-card__offset-step--up");

  down?.addEventListener("click", (event) => {
    event.stopPropagation();
    if (card.classList.contains("is-off")) return;
    card.dataset.target = String(clampSp(parseFloat(card.dataset.target) - SP_STEP));
    paintCard(card);
  });
  up?.addEventListener("click", (event) => {
    event.stopPropagation();
    if (card.classList.contains("is-off")) return;
    card.dataset.target = String(clampSp(parseFloat(card.dataset.target) + SP_STEP));
    paintCard(card);
  });
  oDown?.addEventListener("click", (event) => {
    event.stopPropagation();
    if (card.classList.contains("is-off")) return;
    card.dataset.offset = String(clampOff(parseFloat(card.dataset.offset) - OFFSET_STEP));
    paintCard(card);
  });
  oUp?.addEventListener("click", (event) => {
    event.stopPropagation();
    if (card.classList.contains("is-off")) return;
    card.dataset.offset = String(clampOff(parseFloat(card.dataset.offset) + OFFSET_STEP));
    paintCard(card);
  });
  power?.addEventListener("click", (event) => {
    event.stopPropagation();
    const off = !card.classList.contains("is-off");
    card.classList.toggle("is-off", off);
    card.classList.toggle("is-heating", !off && card.dataset.room === "living");
    power.setAttribute("aria-pressed", off ? "true" : "false");
    paintCard(card);
  });
  paintCard(card);
}

function bindStart() {
  const start = document.querySelector(".start");
  const nav = document.querySelector(".panel-nav");
  const live = document.getElementById("live");
  const shell = document.getElementById("board") || document.querySelector(".board");
  const next = document.getElementById("next-control");
  const nextLabel = document.getElementById("next-label");
  if (!start) return;
  start.addEventListener("click", () => {
    const running = start.getAttribute("aria-pressed") === "true";
    start.setAttribute("aria-pressed", running ? "false" : "true");
    start.setAttribute("aria-label", running ? "Start heating" : "Stop heating");
    start.innerHTML = running
      ? '<svg width="12" height="12" viewBox="0 0 12 12" aria-hidden="true"><polygon points="3,2 10,6 3,10" fill="currentColor"/></svg>'
      : '<svg width="12" height="12" viewBox="0 0 12 12" aria-hidden="true"><rect x="2" y="2" width="8" height="8" rx="1" fill="currentColor"/></svg>';
    nav?.classList.toggle("is-live", !running);
    if (live) live.innerHTML = running ? "<i></i> Stopped" : "<i></i> Live";
    shell?.classList.toggle("is-stopped", running);
    if (next) next.textContent = running ? "—" : "11:02";
    if (nextLabel) nextLabel.textContent = running ? "Stopped" : "Next control";
  });
}

bindStart();
document.querySelectorAll(".climate-card[data-room]").forEach(bindCard);

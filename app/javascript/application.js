// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"

// Disabling Stimulus because not used
// import "./controllers"


function downloadSvg (filename, svgBody) {
  const urlData = btoa(svgBody);
  const link = document.createElement("a");
  link.download = filename;
  link.href = 'data:image/svg+xml;base64,' + urlData;
  link.click();
}
window.downloadSvg = downloadSvg;
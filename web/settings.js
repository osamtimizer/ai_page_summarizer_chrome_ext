document.addEventListener('DOMContentLoaded', function() {
  chrome.storage.sync.get({ "apiKey": "" }, (data) => {
    console.log(`saved key: ${data.apiKey}`);
    let apiKeyField = document.getElementById("apiKey");
    apiKeyField.value = data.apiKey;
  });

  let saveButton = document.getElementById("updateApiKey");

  saveButton.addEventListener("click", () => {
    let apiKeyField = document.getElementById("apiKey");
    let apiKey = apiKeyField.value;
    if (apiKey === undefined || apiKey === "") {
      return;
    }

    chrome.storage.sync.set({ "apiKey": apiKey }, function() {
      console.log("Option saved: " + apiKey);
      let savedLabel = document.getElementById("savedLabel");
      if (savedLabel && savedLabel.hasAttribute("hidden")) {
        savedLabel.style.display = 'block';
        savedLabel.removeAttribute('hidden');
      }
    });
  });
});

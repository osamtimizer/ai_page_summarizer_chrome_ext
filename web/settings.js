document.addEventListener('DOMContentLoaded', function() {
  // api key setting
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
      let savedLabel = document.getElementById("savedLabelApiKey");
      if (savedLabel && savedLabel.hasAttribute("hidden")) {
        savedLabel.style.display = 'block';
        savedLabel.removeAttribute('hidden');
        setTimeout(function() {
          savedLabel.style.display = 'none';
          savedLabel.setAttribute('hidden', true);
        }, 3000);
      }
    });
  });

  // Language settings
  let dropdown = document.getElementById("language");
  dropdown.addEventListener("change", function(){
    var selectedOption = dropdown.options[dropdown.selectedIndex].value;
    if (selectedOption !== undefined && selectedOption !== "") {
      chrome.storage.sync.set({ "language": selectedOption }, function() {
        console.log("Option saved: " + selectedOption);
      let savedLabel = document.getElementById("savedLabelLanguage");
      if (savedLabel && savedLabel.hasAttribute("hidden")) {
        savedLabel.style.display = 'block';
        savedLabel.removeAttribute('hidden');
        setTimeout(function() {
          savedLabel.style.display = 'none';
          savedLabel.setAttribute('hidden', true);
        }, 3000);
      }
      });
    }
  });

  chrome.storage.sync.get({ "language": "" }, (data) => {
    let dropdown = document.getElementById("language");
    switch(data.language) {
      case "":
        dropdown.selectedIndex = 0;
        break;
      case "english":
        dropdown.selectedIndex = 0;
        break;
      case "japanese":
        dropdown.selectedIndex = 1;
        break;
    }
  });
});

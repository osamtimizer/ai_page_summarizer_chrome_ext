async function getSelectedText() {
  let result = null;
  result = await queryTabs();
  console.log(`result is ${result}`);
  return result;
}

function queryTabs() {
  console.log("queryTab");
  return new Promise((resolve, reject) => {
    let result = null;
    chrome.tabs.query( {active:true, currentWindow:true}, async function(tabs) {
      console.log("chrome.tabs.query");
      await chrome.tabs.sendMessage(tabs[0].id, {message: 'get selection'}, function(item) {
        console.log("chrome.tabs.sendMessage");
        if (chrome.runtime.lastError) {
          console.log("runtime error on chrome.runtime");
          reject(chrome.runtime.lastError);
        }

        if(!item){
          reject("no text selection");
        }

        result = item;
        resolve(result);
      });

      if (chrome.runtime.lastError) {
        console.log("runtime error on chrome.runtime");
        reject(chrome.runtime.lastError);
      }

      return true;
    });
  })
}

async function getSavedApiKey() {
  return promisifyChromeStorageGetApiKey();
}

function promisifyChromeStorageGetApiKey() {
  return new Promise((resolve, reject) => {
    chrome.storage.sync.get({ "apiKey": "" }, function(data) {
      if (chrome.runtime.lastError) {
        reject(chrome.runtime.lastError);
      } else {
        resolve(data.apiKey);
      }
    });
  });
}

async function getLanguage() {
  return promisifyChromeStorageGetLanguage();
}

function promisifyChromeStorageGetLanguage() {
  return new Promise((resolve, reject) => {
    chrome.storage.sync.get({ "language": "" }, function(data) {
      if (chrome.runtime.lastError) {
        reject(chrome.runtime.lastError);
      } else {
        resolve(data.language);
      }
    });
  });
}
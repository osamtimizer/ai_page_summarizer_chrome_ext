async function getSelectedText() {
  let result = null;
  result = await queryTabs();
  console.log(`result is ${result}`);
  return result;
}

function queryTabs() {
  return new Promise(resolve => {
    let result = null;
    chrome.tabs.query( {active:true, currentWindow:true}, async function(tabs) {
      await chrome.tabs.sendMessage(tabs[0].id, {message: 'get selection'}, function(item) {
        if(!item){
          return;
        }
        result = item;
        resolve(result);
      });
      return true;
    });
  })
}

getSelectedText();
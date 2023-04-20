async function getSelectedText() {
  let result = null;
  result = await queryTabs();
  console.log(`got result is ${result}`);
  return result;
}

function queryTabs() {
  return new Promise(resolve => {
    let result = null;
    chrome.tabs.query( {active:true, currentWindow:true}, async function(tabs) {
      console.log('tabs query');
      await chrome.tabs.sendMessage(tabs[0].id, {message: 'get selection'}, function(item) {
        console.log("send message");
        if(!item){
          return;
        }
        result = item;
        console.log(`chrome_api item is ${item}`);
        resolve(result);
      });
      return true;
    });
  })
}

getSelectedText();
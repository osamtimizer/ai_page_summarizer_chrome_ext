chrome.runtime.onMessage.addListener((message) => {
  const selectedText = message.selectedText;

  // 受信したデータを使って何らかの処理を行う
  console.log(selectedText);
  return true;
});
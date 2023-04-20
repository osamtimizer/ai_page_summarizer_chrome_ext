chrome.runtime.onInstalled.addListener(function (details) {
  /* コンテキストメニューを作成 */
  const parent = chrome.contextMenus.create({
    id: "share",
    title: "ページを共有",
    contexts: ["all"],
  });

  // (中略)
});

async function createContextMenu() {
  const parent = chrome.contextMenus.create({
    id: "share",
    title: "ページを共有",
    contexts: ["all"],
  });

  // (中略)
}
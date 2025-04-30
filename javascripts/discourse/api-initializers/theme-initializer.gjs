import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  
  //timeline滾動時改變date顏色
window.addEventListener("scroll", function() {
    let scrollPercentage = window.scrollY / (document.body.scrollHeight - window.innerHeight);
    
    let startColor = interpolateColor("#FFD306", "#909090", scrollPercentage);
    let nowColor = interpolateColor("#909090", "#FFD306", scrollPercentage);

    document.querySelector(".start-date").style.color = startColor;
    document.querySelector(".now-date").style.color = nowColor;
});

function interpolateColor(color1, color2, factor) {
    let c1 = parseInt(color1.slice(1), 16),
        c2 = parseInt(color2.slice(1), 16);

    let r1 = (c1 >> 16) & 0xff, g1 = (c1 >> 8) & 0xff, b1 = c1 & 0xff;
    let r2 = (c2 >> 16) & 0xff, g2 = (c2 >> 8) & 0xff, b2 = c2 & 0xff;

    let r = Math.round(r1 + factor * (r2 - r1));
    let g = Math.round(g1 + factor * (g2 - g1));
    let b = Math.round(b1 + factor * (b2 - b1));

    return `rgb(${r},${g},${b})`;
}

// 定義手機版的最大寬度
const mobileMedia = window.matchMedia("(max-width: 1024px)");

// 追蹤視窗寬度變化
mobileMedia.addEventListener("change", function(e) {
    if (!e.matches) {
        // 代表從手機版切回電腦版
        console.log("切回電腦版，執行 JavaScript");
        runDesktopScripts();
    }
});

// 重新執行 JavaScript 的函式
function runDesktopScripts() {
    // 要重新執行的 JS
    window.addEventListener("scroll", function() {
    let scrollPercentage = window.scrollY / (document.body.scrollHeight - window.innerHeight);
    
    let startColor = interpolateColor("#FFD306", "#909090", scrollPercentage);
    let nowColor = interpolateColor("#909090", "#FFD306", scrollPercentage);

    document.querySelector(".start-date").style.color = startColor;
    document.querySelector(".now-date").style.color = nowColor;
});

function interpolateColor(color1, color2, factor) {
    let c1 = parseInt(color1.slice(1), 16),
        c2 = parseInt(color2.slice(1), 16);

    let r1 = (c1 >> 16) & 0xff, g1 = (c1 >> 8) & 0xff, b1 = c1 & 0xff;
    let r2 = (c2 >> 16) & 0xff, g2 = (c2 >> 8) & 0xff, b2 = c2 & 0xff;

    let r = Math.round(r1 + factor * (r2 - r1));
    let g = Math.round(g1 + factor * (g2 - g1));
    let b = Math.round(b1 + factor * (b2 - b1));

    return `rgb(${r},${g},${b})`;
    }
}
/*-------------結束---------------*/

// 移動header-sidebar-toggle位置 (不用了但留著參考)

/*api.onPageChange(() => {
  const toggle = document.querySelector('.header-sidebar-toggle');
  const icons = document.querySelector('.d-header-icons');

  if (toggle && icons && !document.querySelector('.header-sidebar-toggle-li')) {
    // 包裝成 li
    const li = document.createElement('li');
    li.className = 'header-sidebar-toggle-li header-dropdown-toggle';
    li.appendChild(toggle);

    // 插入到第4個位置（index = 3）
    const position = 3;
    const children = icons.children;

    if (children.length >= position) {
      icons.insertBefore(li, children[position]);
    } else {
      icons.appendChild(li);
    }
  }
});*/

/*-------------結束---------------*/

//popup訊息存在與否，預覽畫面的變化
/*document.addEventListener('DOMContentLoaded', function () {
    let editorPreviewWrapper = null;

    // 專門等待 d-editor-preview-wrapper 出現
    const waitForEditorPreview = new MutationObserver(() => {
        editorPreviewWrapper = document.querySelector('.d-editor-preview-wrapper');
        if (editorPreviewWrapper) {
            console.log('✅ 找到 .d-editor-preview-wrapper 了');

            // 找到後，馬上停止這個 observer
            waitForEditorPreview.disconnect();

            // 開始正常監聽 composer-popup
            setupPopupWatcher();
        }
    });

    waitForEditorPreview.observe(document.body, {
        childList: true,
        subtree: true
    });

    function setupPopupWatcher() {
        const checkPopupStatus = () => {
            const composerPopup = document.querySelector('.composer-popup.ember-view');
            if (composerPopup) {
                editorPreviewWrapper.style.paddingRight = '30vw';
            } else {
                editorPreviewWrapper.style.paddingRight = '0';
            }
        };

        // 初次檢查
        checkPopupStatus();

        // 持續監聽 popup 出現/消失
        const popupObserver = new MutationObserver(() => {
            checkPopupStatus();
        });

        popupObserver.observe(document.body, {
            childList: true,
            subtree: true
        });

        // 額外保險：每10秒檢查一次
        setInterval(checkPopupStatus, 10000);
    }
});*/

/*document.addEventListener('DOMContentLoaded', function () {
    let editorPreviewWrapper = null;
    let popupObserver = null; // 防止重複開 observer

    // 專門等待 d-editor-preview-wrapper 出現
    const waitForEditorPreview = new MutationObserver(() => {
        editorPreviewWrapper = document.querySelector('.d-editor-preview-wrapper');
        if (editorPreviewWrapper) {
            console.log('✅ 找到 .d-editor-preview-wrapper 了');

            // 找到後，馬上停止這個 observer
            waitForEditorPreview.disconnect();

            // 開始監聽 popup
            setupPopupWatcher();
        }
    });

    waitForEditorPreview.observe(document.body, {
        childList: true,
        subtree: true
    });

    function setupPopupWatcher() {
        const checkPopupStatus = () => {
            const composerPopup = document.querySelector('.composer-popup.ember-view');
            if (composerPopup) {
                editorPreviewWrapper.style.paddingRight = '30vw';
            } else {
                editorPreviewWrapper.style.paddingRight = '0';
            }
        };

        // 初次檢查一次
        checkPopupStatus();

        // 如果之前已經有 observer，先關掉，避免重複
        if (popupObserver) {
            popupObserver.disconnect();
        }

        popupObserver = new MutationObserver(() => {
            checkPopupStatus();
        });

        popupObserver.observe(document.body, {
            childList: true,
            subtree: true
        });

        // 額外保險：每10秒檢查一次
        setInterval(checkPopupStatus, 10000);
    }
});*/

document.addEventListener('DOMContentLoaded', function () {
    let editorPreviewWrapper = null;
    let popupObserver = null;
    let previewObserver = null;

    function getEditorPreviewWrapper() {
        return document.querySelector('.d-editor-preview-wrapper');
    }

    function checkAndUpdatePadding() {
        if (!editorPreviewWrapper) return;

        const composerPopup = document.querySelector('.composer-popup.ember-view');
        const composerVisible = composerPopup && !composerPopup.classList.contains('hidden');

        editorPreviewWrapper.style.paddingRight = composerVisible ? '30vw' : '0';
    }

    function setupPopupWatcher() {
        if (popupObserver) {
            popupObserver.disconnect();
        }

        popupObserver = new MutationObserver(() => {
            checkAndUpdatePadding();
        });

        popupObserver.observe(document.body, {
            childList: true,
            subtree: true,
            attributes: true,
            attributeFilter: ['class']
        });
    }

    function setupEditorPreviewWatcher() {
        if (previewObserver) {
            previewObserver.disconnect();
        }

        previewObserver = new MutationObserver(() => {
            editorPreviewWrapper = getEditorPreviewWrapper();
            if (editorPreviewWrapper) {
                console.log('✅ editorPreviewWrapper');
                checkAndUpdatePadding();
            } else {
                console.warn('⚠️ editorPreviewWrapper消失');
            }
        });

        previewObserver.observe(document.body, {
            childList: true,
            subtree: true
        });
    }

    // 初始啟動
    editorPreviewWrapper = getEditorPreviewWrapper();

    if (editorPreviewWrapper) {
        console.log('✅ 一開始就有 editorPreviewWrapper');
        setupPopupWatcher();
        setupEditorPreviewWatcher();
        checkAndUpdatePadding();
    } else {
        console.log('⏳ 沒找到 editorPreviewWrapper，等待...');
        setupEditorPreviewWatcher();
    }
});

//移動searchbar到header
document.addEventListener("DOMContentLoaded", function () {
  const searchMenu = document.querySelector(".welcome-banner__wrap .search-menu");
  const container = document.querySelector(".drop-down-mode .d-header .contents");

  if (searchMenu && container) {
    const allDivs = container.querySelectorAll("div");

    // 如果至少有2個元素，插入在第2個之後（變成第3個）
    if (allDivs.length >= 2) {
      container.insertBefore(searchMenu, allDivs[2]);
    } else {
      container.appendChild(searchMenu); // 如果不足，直接放最後
    }
  }
});



// 移動#new-create-topic按鈕位置到header icon
document.addEventListener("DOMContentLoaded", function () {
  const buttonWrapper = document.querySelector(".fk-d-button-tooltip");
  const panel = document.querySelector(".panel");
  const ulIcons = panel?.querySelector(".icons.d-header-icons");

  if (buttonWrapper && panel && ulIcons) {
    const button = buttonWrapper.querySelector("button");

    // ✅ 修改按鈕樣式，讓它和 header icon 一致
    button.className = "btn no-text btn-icon icon btn-flat";

    // ✅ 用一個新的 <li> 包裹整個 buttonWrapper
    const newLi = document.createElement("li");
    newLi.className = "header-dropdown-toggle header-icon-create-topic";
    newLi.appendChild(buttonWrapper); // 加入整個 div

    // ✅ 插入到 <ul> 中（可選擇位置）
    ulIcons.insertBefore(newLi, ulIcons.firstChild); // 放第一個
  }
});

});

import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  // Your code here
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
    // 這裡放你要重新執行的 JavaScript 程式
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

// 移動header-sidebar-toggle位置

api.onPageChange(() => {
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
});


});

$(function () {
  // トップページユーザーボタン
  $(document).on("mouseover", ".user-area > li > a", function () {
    $(this).css({ "color": "#7B68EE","border-bottom": "1px solid" });
  }).on("mouseout", ".user-area > li > a", function () {
    $(this).css({ "color": "", "border-bottom": "none" });
  })

  // 投稿画面タイトル
  $(document).on("mouseover", "#tiped-title", function () {
    $(this).css({ "color": "#7B68EE","border-bottom": "1px solid" });
  }).on("mouseout", "#tiped-title", function () {
    $(this).css({ "color": "", "border-bottom": "none" });
  })
  
  // 投稿画面投稿者
  $(document).on("mouseover", "#tiped-title-contents-distributer", function () {
    $(this).css({ "color": "#7B68EE","border-bottom": "1px solid" });
  }).on("mouseout", "#tiped-title-contents-distributer", function () {
    $(this).css({ "color": "", "border-bottom": "none" });
  })

  // ログインページ
  $(document).on("mouseover", ".to-sign-up > a", function () {
    $(this).css({ "color": "#7B68EE","border-bottom": "1px solid" });
  }).on("mouseout", ".to-sign-up > a", function () {
    $(this).css({ "color": ""});
  })

  // 新規登録ページ
  $(document).on("mouseover", ".to-sign-in > a", function () {
    $(this).css({ "color": "#7B68EE","border-bottom": "1px solid" });
  }).on("mouseout", ".to-sign-in > a", function () {
    $(this).css({ "color": ""});
  })

  // 詳細ページ投稿者
  $(document).on("mouseover", "#tip-show-contributor", function () {
    $(this).css({ "color": "#7B68EE","border-bottom": "1px solid" });
  }).on("mouseout", "#tip-show-contributor", function () {
    $(this).css({ "color": "", "border-bottom": "none"});
  })

  // 詳細ページpdfリンク
  $(document).on("mouseover", ".pdf-layout > a", function () {
    $(this).css({ "color": "#7B68EE","border-bottom": "1px solid" });
  }).on("mouseout", ".pdf-layout > a", function () {
    $(this).css({ "color": "", "border-bottom": "none"});
  })
});
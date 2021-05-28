$(function () {
  $(".like-appear-str").on("click", function () {
    // トップページの表示の切り替え
    like_text = $(".like-appear-str").text()
    if (like_text == "投稿一覧 >>"){
      $(".like-appear-str").text("いいね一覧 >>")
    }
    else{
      $(".like-appear-str").text("投稿一覧 >>")
    }
    tip_text = $(".tiplist-likelist").text()
    if (tip_text == "いいね一覧"){
      $(".tiplist-likelist").text("投稿一覧")
      $("#tip-list-area").css("display", "block")
      $("#like-list-area").css("display", "none")
    }
    else {
      $(".tiplist-likelist").text("いいね一覧")
      $("#tip-list-area").css("display", "none")
      $("#like-list-area").css("display", "block")
    }
  })
});
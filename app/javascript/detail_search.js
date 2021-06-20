window.addEventListener('load', function(){
  // 詳細検索
  const searchBtn   = document.getElementById("search-btn")
  const visibleTrue = document.getElementById("detail-search-area")
  const searchArea  = document.getElementById("search")
  // 新規投稿
  const newTipArea  = document.getElementById("new-tip")
  const newTipBtn   = document.getElementById("new-tip-btn")
  // トレンド
  const newTrendArea = document.getElementById("new-trend")
  const newTrendBtn  = document.getElementById("trend-btn")
  // マイページ
  const myPageArea = document.getElementById("my-page")
  const myPageBtn  = document.getElementById("my-page-btn")
  
  // 詳細検索の時はサイドバーの検索をON、バックグラウンド
  const path = location.pathname ;
  if (path == "/tips/detail_search"){
    visibleTrue.getAttribute("style")
    visibleTrue.setAttribute("style", "display:block;")
    searchArea.setAttribute("style", "background-color:rgb(230, 230, 230);")
  }

  // 詳細検索
  searchBtn.addEventListener('mouseover', function(){
    searchArea.setAttribute("style", "background-color:rgb(230, 230, 230);")
  })
  searchBtn.addEventListener('mouseout', function(){
    if (visibleTrue.getAttribute("style") != "display:block;"){
      searchArea.removeAttribute("style", "background-color:rgb(230, 230, 230);")
    }
  })
  searchBtn.addEventListener('click', function(){
    if (visibleTrue.getAttribute("style") == "display:block;"){
      visibleTrue.setAttribute("style", "display:none;")
      searchArea.removeAttribute("style", "background-color:rgb(230, 230, 230);")
    }else{
      visibleTrue.setAttribute("style", "display:block;")
      searchArea.setAttribute("style", "background-color:rgb(230, 230, 230);")
    }
  })
  // 新規投稿
  newTipBtn.addEventListener('mouseover', function(){
    newTipArea.setAttribute("style", "background-color:rgb(230, 230, 230);")
  })
  newTipBtn.addEventListener("mouseout", function(){
    newTipArea.removeAttribute("style", "background-color:rgb(230, 230, 230);")
  })
  // 質問する
  newTrendBtn.addEventListener('mouseover', function(){
    newTrendArea.setAttribute("style", "background-color:rgb(230, 230, 230);")
  })
  newTrendBtn.addEventListener("mouseout", function(){
    newTrendArea.removeAttribute("style", "background-color:rgb(230, 230, 230);")
  })
  // マイページ
  myPageBtn.addEventListener('mouseover', function(){
    myPageArea.setAttribute("style", "background-color:rgb(230, 230, 230);")
  })
  myPageBtn.addEventListener("mouseout", function(){
    myPageArea.removeAttribute("style", "background-color:rgb(230, 230, 230);")
  })
})

$(function(){
  $('.tip-image-main-img').on("input", function(e) {
        // ファイル情報を取得
        var fileData = e.target.files[0];
        if (fileData.type == "application/pdf"){
          
          //サムネイル表示エリアのエレメント取得
          var object = $(this).parent().children('div').children('object').get(0);
          $(function(){
            $('.pdf-visible').css('display', 'block')
          })
          // FileReaderオブジェupload_fileクトを使ってファイル読み込み
          var reader = new FileReader();
          // ファイル読取り成功時処理
          reader.onload = function() {
        
              //ノードの複製
              var cln = object.cloneNode(true);
        
              //複製したノードのdata要素をにFileAPIの読み込み結果をセット
              cln.setAttribute("data",reader.result);
        
              object.parentNode.replaceChild(cln, object);
          }
          // ファイル読み込みを実行
          reader.readAsDataURL(fileData);
        }
  })
})
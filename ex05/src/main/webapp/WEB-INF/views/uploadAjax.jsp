<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>upload with Ajax</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function (){
            let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
            let maxSize = 5242880; //5MB

            function checkExtension(fileName, fileSize) {

                if (fileSize >= maxSize) {
                    alert("파일 사이즈 초과");
                    return false;
                }

                if (regex.test(fileName)) {
                    alert("해당 종류의 파일은 업로드할 수 없습니다.");
                    return false;
                }
                return true;
            }


            $("#uploadBtn").on("click", function (e){

            let formData = new FormData();
            let inputFile = $("input[name='uploadFile']");
            let files = inputFile[0].files;

            console.log(files);

               /* add filedate to formata */
               for(let i = 0; i< files.length; i++){
                   if(!checkExtension(files[i].name, files[i].size)){
                       return false;
                   }

                   formData.append("uploadFile", files[i]);
               }

               $.ajax({
                   url: '/uploadAjaxAction',
                   processData: false,
                   contentType: false,
                   data: formData,
                   type: 'POST',
                   success: function (result){
                       //alert("Uploaded");
                       console.log(result);

                       showUploadFile(result);

                       $(".uploadDiv").html(cloneObj.html());

                   }
               }); //$.ajax
           });

            let uploadResult =$(".uploadResult ul")
            function showUploadFile(uploadResultArr){

                let str = "";
                $(uploadResultArr).each(function (i, obj){

                    str += "<li>" + obj.fileName + "</li>";
                });
                uploadResult.append(str);
            }


        });

    </script>

</head>
<body>
<h1>Upload with Ajax</h1>

<div class='uploadDiv'>
    <input type='file' name='uploadFile' multiple>
</div>
<div class='uploadResult'>
    <ul>

    </ul>
</div>
<button id='uploadBtn'>Upload</button>

</body>
</html>

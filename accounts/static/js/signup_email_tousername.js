$(document).ready(function(){

    function setUsernameValue(username_field,str){
        $(username_field).val(str);
    }

     $(".form-sign-up").each(function(){
         var username_field = $(this).find("input[name='username']")[0];
         var email_field  = $(this).find("input[name='email']")[0];
         setUsernameValue(username_field,email_field.value)
        $(email_field).change(function(){
            var form = $(this).parents("form")[0];
            var _username = $(form).find("input[name='username']")[0];
            setUsernameValue(_username,this.value)
        });
    })

});
$(document).ready(function(){

    function generateUUID() {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxxxxxx4xxxyxxx-xxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random()*16)%16 | 0;
        d = Math.floor(d/16);
        return (c=='x' ? r : (r&0x3|0x8)).toString(16);
    });
    return uuid;

    };

     function set_user_UUID(username_input){
        $(username_input).val(generateUUID());
    }

     $(".form-sign-up").each(function(){
        var username_field = $(this).find("input[name='username']")[0];
        set_user_UUID(username_field);
    })

});
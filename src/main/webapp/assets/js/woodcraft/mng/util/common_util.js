/**
 * Created with IntelliJ IDEA.
 * User: jojungho
 * Date: 2014. 1. 7.
 * Time: 오후 10:07
 * To change this template use File | Settings | File Templates.
 */

(function($){
    $.fn.dayValidation = function(){
        return this.focus(function(){
           $(this).stop().etcValueChange();
        }).blur(function(){
           $(this).stop().dayValidate();
        });
    }
    $.fn.timeValidation = function(){
        return this.focus(function(){
            $(this).etcValueChange();
        }).blur(function(){
            $(this).timeValidate();
        });
    }
    $.fn.house_numberValidation = function(){
        return this.focus(function(){
            $(this).stop().etcValueChange();
        }).blur(function(){
            $(this).stop().house_numberValidate();
        });
    }
    $.fn.phone_numberValidation = function(){
        return this.focus(function(){
            $(this).etcValueChange();
        }).blur(function(){
            $(this).phone_numberValidate();
        });
    }
    $.fn.emailValidation = function(){
        return this.blur(function(){
            $(this).emailValidate();
        });
    }

    $.fn.etcValueChange = function(){
        var contentText = $(this).val().replace(/[-.:]/g,"");
        $(this).val(contentText);
    }
    $.fn.dayValidate = function(){
        var contentText = $(this).val().replace(/[-.]/g,"");
        var regex =/^\d{8}$/;
        if(regex.test(contentText)){
            var y = contentText.substr(0,4);
            var m = contentText.substr(4,2);
            var d = contentText.substr(6,2);

            var dt = new Date(parseInt(y),parseInt(m)-1,parseInt(d));
            if(dt.getFullYear() == parseInt(y) && dt.getMonth() == (parseInt(m)-1) && dt.getDate() == parseInt(d)){
                $(this).val(y+"-"+m+"-"+d);
                return true;
            } else {
                return messageAlert("날짜 형식을 확인해주세요",$(this),contentText);;
            }
        } else {
            return messageAlert("날짜 형식을 확인해주세요",$(this),contentText);
        }
    }

    $.fn.timeValidate = function(){
        var contentText = $(this).val().replace(/[:.]/g,"");
        var regex =/^\d{4}$/;
        if(regex.test(contentText)){
            var h = contentText.substr(0,2);
            var m = contentText.substr(2,2);

            var dt = new Date();
            dt.setHours(parseInt(h));
            dt.setMinutes(parseInt(m));

            if(dt.getHours() == parseInt(h) && dt.getMinutes() == parseInt(m)){
                $(this).val(h+":"+m);
                return true;
            } else {
                return  messageAlert("시간 형식을 확인해주세요",$(this),contentText);;
            }
        } else {
            return messageAlert("시간 형식을 확인해주세요",$(this),contentText);
        }
    }
    $.fn.phone_numberValidate = function(){

        var contentText = $(this).val().replace(/[-.]/g,"");
        var regex = /^(01[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;

        if(contentText.length <= 11 && contentText.length > 9){
            if(regex.test($(this).val())){
                var first = contentText.substr(0,3);
                var middle = (contentText.length == 11)?contentText.substr(3,4):contentText.substr(3,3);
                var end = (contentText.length == 11)?contentText.substr(7,4):contentText.substr(6,4);
                $(this).val(first+"-"+middle+"-"+end);
                return true;
            } else {
                return messageAlert("휴대폰 번호 확인을 부탁드립니다.",$(this),contentText);
            }
        } else if(contentText.length == 0){
            return true;
        } else {
            return messageAlert("휴대폰 번호 확인을 부탁드립니다.",$(this),contentText);
        }
    }
    $.fn.house_numberValidate = function(){

        var contentText = $(this).val().replace(/[-.]/g,"");
        var regex = /^(0[0-9]{2}|02)-?[0-9]{3,4}-?[0-9]{4}$/;

        if(contentText.length <= 11 && contentText.length > 8){
            if(regex.test($(this).val())){
                var first = (contentText.length == 9)?contentText.substr(0,2):contentText.substr(0,3);
                var middle = "";
                var end ="";
                if(first.length > 2){
                    middle = (contentText.length == 11)?contentText.substr(3,4):contentText.substr(3,3);
                    end = (contentText.length == 11)?contentText.substr(7,4):contentText.substr(6,4);
                } else {
                    middle = (contentText.length == 10)?contentText.substr(2,4):contentText.substr(2,3);
                    end = (contentText.length == 10)?contentText.substr(6,4):contentText.substr(5,4);
                }
                $(this).val(first+"-"+middle+"-"+end);
                return true;
            } else {
                return messageAlert("전화번호 확인을 부탁드립니다.",$(this),contentText);
            }
        } else if(contentText.length == 0){
            return true;
        } else {
            return messageAlert("전화번호 확인을 부탁드립니다.",$(this),contentText);
        }
    }
    $.fn.emailValidate = function(){
        var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
        var contentText = $(this).val();

        if(regex.test(contentText)){
            return true;
        } else {
            return messageAlert("이메일 확인을 부탁드립니다.",$(this),contentText);
        }
    }
    messageAlert = function(messages,e,contentText){
        alert(messages);
        e.val(contentText);
        e.focus();
        return false;
    }

})(jQuery)

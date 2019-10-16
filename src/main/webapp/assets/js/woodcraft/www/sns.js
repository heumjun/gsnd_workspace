$(document).ready(function () {

    //공유하기 함수
    function share(shareTy) {
        var linkUrl = encodeURIComponent(document.location.href);
        var linkUrl2 = document.location.href;
        var title = encodeURIComponent(document.getElementsByTagName('TITLE')[0].text);
        var _br = encodeURIComponent('\r\n');
        var _br2 = encodeURIComponent('\n');
        var url = "";
        switch (shareTy) {
            case 'facebook':
                url = 'https://www.facebook.com/sharer/sharer.php?u=' + linkUrl;
                break;
            case 'twitter':
                url = 'https://twitter.com/intent/tweet?text=' + title + '&url=' + linkUrl + '&original_referer=' + linkUrl;
                break;
            case 'blog':
                url = 'http://share.naver.com/web/shareView.nhn?url=' + linkUrl + '&title=' + title;
                break;
            case 'kakao':
                url = 'https://story.kakao.com/share?url=' + linkUrl + '&text=' + title;
                break;
            case 'band':
                //  url = 'http://band.us/plugin/share?body='+ title +'&route='+linkUrl;
                url = 'http://www.band.us/plugin/share?body=' + title + '' + _br2 + '' + linkUrl + '&route=www.pen.go.kr';
                break;
        }

        window.open(url, shareTy, 'location=1,scrollbars=auto,resizable=no,top=25,left=100,width=600,height=500');
    }

    $(function () {
        $('#btnFacebook').click(function () {
            share("facebook");
        });

        $('#btnTwitter').click(function () {
            share("twitter");
        });

        $('#btnKakao').click(function () {
            share("kakao");
        });

        $('#btnBlog').click(function () {
            share("blog");
        });

        $('#btnBand').click(function () {
            share("band");
        });
    });
});
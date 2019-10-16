
$(document).ready(function() {
    // Hide submenus
    // $("div.vNav ul ul").hide();

    // Toggle nested <ul> (siblings of the link)
    /*
    $("div.vNav ul  li > a[href=#]").click(function(e) {

        e.preventDefault();

        var toggle = $(this).attr("data-toggle-state");

        var prev_anchor =  $(this).parent("li").siblings("li").find('a[data-toggle-state="true"]');
        if (prev_anchor.length != 0) {

            $(prev_anchor).parent("li").siblings("li").removeClass("active");
            $(prev_anchor).parent('li').find('a[data-toggle-state]').each(function(index, item) {
                $(item).attr('data-toggle-state',"false");
            });

            $(prev_anchor).parent("li").siblings("li").find("li").each(function(index, item) {
                $(item).removeClass("active");
            });

            $(prev_anchor).attr('data-toggle-state',"false");
            $(prev_anchor).siblings("ul").slideToggle();
        }

        if (toggle !== undefined) {

            if (toggle == "false") {

                $(this).parent("li").siblings("li").removeClass("active");
                $(this).siblings("ul").slideToggle();
                $(this).attr('data-toggle-state', "true");
                $(this).parent('li').addClass('active');
            }
        } else {

            $(this).parent("li").siblings("li").removeClass("active");
            $(this).parent('li').addClass('active');
        }
    });
    */
});




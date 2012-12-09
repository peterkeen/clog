$(function() {
    $(".tagmanager").each(function(i,e) {
        var element = $(e);
        var prefilled = []
        if(element.val() != "") {
            prefilled = element.val().split(/,\s*/)
        }
        element.val("");
        
        element.tagsManager({
            preventSubmitOnEnter: true,
            typeahead: true,
            prefilled: prefilled,
            typeaheadAjaxSource: '/recipients/tags',
            blinkBGColor_1: '#FFFF9C',
            blinkBGColor_2: '#CDE69C',
        });
    });
});

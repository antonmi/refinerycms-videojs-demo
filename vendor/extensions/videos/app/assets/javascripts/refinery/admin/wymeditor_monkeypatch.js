$insert_video_link = "<ul style='cursor: pointer' id='add_video'><li><a href='/refinery/videos/insert?dialog=true'>Add Video</a></li></ul>";
window.onload = function ()
{
    if ($.wymeditors(0)) {
        $('.wym_area_top').append($insert_video_link);
        init_modal_dialogs();
    }
};

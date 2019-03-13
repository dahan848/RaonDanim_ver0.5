/****************************************
 IMAGE BACKGROUND
 *****************************************/

var $image_crop = $("#image-crop");
var $modal_profile_image = $("#modal-profile-image");
var $input_cropping = $("#id_image_cropping");
var $input_cropping_temp = $("#id_image_cropping_temp");
var $input_do_save_image = $("#id_do_save_image");
var $loading_mask = $(".loading-mask");
var is_image_uploaded = false;
var $crop_preview = $("#crop-preview");

$modal_profile_image.on('shown.bs.modal', function () {
    initCrop();
});

$modal_profile_image.on('hide.bs.modal', function () {
    $crop_preview.hide();
    // $image_crop.cropper('destroy');
});

function setBackground(input, target) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $(target).css('background-image', 'url(' + e.target.result + ')');
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function setCropImage() {
    var data = new FormData();
    var user_id = $('#form-profile-update').attr('data-user-id');

    data.append('image_temp', $('#id_image_temp')[0].files[0]);
    $loading_mask.show();

    $.ajax({
        url: '/api/profiles/' + user_id + '/',
        processData: false,
        contentType: false,
        data: data,
        method: 'PUT',
        success: function(result){
            $image_crop.attr('src', result.image_temp);
            is_image_uploaded = true;
            $loading_mask.hide();
            initCrop();
        },
        fail: function (result) {
            console.log(result);
        }
    });
}

function initCrop() {
    var crop = $input_cropping.val().split(",");
    var data = null;
    if (crop.length === 4) {
        data = {
            x: parseInt(crop[0]),
            y: parseInt(crop[1]),
            width: parseInt(crop[2]) - parseInt(crop[0]),
            height: parseInt(crop[3]) - parseInt(crop[1])
        };
    }
    $input_do_save_image.prop('checked', false);
    $image_crop.cropper('destroy');
    $image_crop.cropper({
        aspectRatio: 1,
        movable: false,
        data: data,
        rotatable: false,
        scalable: false,
        zoomable: false,
        preview: '#crop-preview',
        crop: function(e) {
            var x = Math.round(e.x);
            var y = Math.round(e.y);
            var width = Math.round(e.width) + x;
            var height = Math.round(e.height) + y;
            var cropping = x + ',' + y + ',' + width + ',' + height;
            $input_cropping_temp.val(cropping);
        }
    });
}

$("#id_image_temp").change(function () {
    setCropImage();
});

$("#id_image_cover").change(function () {
    setBackground(this, '.profile-image');
});

$("#btn-profile-image").click(function () {
    $modal_profile_image.modal('show');
});

$("#btn-image-upload").click(function () {
    $("#id_image_temp").trigger("click");
});

$("#btn-profile-image-cover").click(function () {
    $("#id_image_cover").trigger("click");
});

$("#btn-crop-confirm").click(function () {
    $input_cropping.val($input_cropping_temp.val());
    if (is_image_uploaded) {
        $input_do_save_image.prop('checked', true);
    }
    $modal_profile_image.modal('hide');
    $crop_preview.show();
});

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<!-- 달력 -->
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"> -->
	
<link href="${contextPath }/css/bootstrap-datetimepicker.css" rel="stylesheet">
<script src="${contextPath }/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${contextPath }/js/bootstrap-datetimepicker.ko.js" type="text/javascript"></script>
<!-- 달력 END -->
<link
	href="https://a0.muscache.com/airbnb/static/packages/dls/common_o2.1_cereal-38a6a6c175aa965641bbe496d3c31e2d.css"
	media="all" rel="stylesheet" type="text/css" />
<link
	href="https://a0.muscache.com/airbnb/static/packages/common-97388ca14753064497bc17ce329ce616.css"
	media="all" rel="stylesheet" type="text/css" />



<link
	href="https://a0.muscache.com/airbnb/static/magic_carpet/magic_carpet-478ef8e4c5a8af6f5988f473a0c68d09.css"
	media="screen" rel="stylesheet" type="text/css" />
<link
	href="https://a0.muscache.com/airbnb/static/magic_carpet/magic_doorway_transitions-c27ffe3f59e9f6681d6f9d0157121e3b.css"
	media="screen" rel="stylesheet" type="text/css" />



<meta name="twitter:widgets:csp" content="on">




<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="image_src"
	href="https://a0.muscache.com/airbnb/static/logos/trips-og-200x200-a3be4fbbb3b6c5e758804438dea35adc.jpg">
<link rel="search" type="application/opensearchdescription+xml"
	href="/opensearch.xml" title="Airbnb">

<link rel="manifest" href="/manifest.json">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="application-name" content="Airbnb">
<meta name="apple-mobile-web-app-title" content="Airbnb">
<meta name="theme-color" content="#ffffff">
<meta name="msapplication-navbutton-color" content="#ffffff">
<meta name="apple-mobile-web-app-status-bar-style"
	content="black-translucent">
<meta name="msapplication-starturl" content="/?utm_source=homescreen">


<link rel="apple-touch-icon"
	href="https://a0.muscache.com/airbnb/static/icons/apple-touch-icon-76x76-3b313d93b1b5823293524b9764352ac9.png" />
<link rel="apple-touch-icon" sizes="76x76"
	href="https://a0.muscache.com/airbnb/static/icons/apple-touch-icon-76x76-3b313d93b1b5823293524b9764352ac9.png" />
<link rel="apple-touch-icon" sizes="120x120"
	href="https://a0.muscache.com/airbnb/static/icons/apple-touch-icon-120x120-52b1adb4fe3a8f825fc4b143de12ea4b.png" />
<link rel="apple-touch-icon" sizes="152x152"
	href="https://a0.muscache.com/airbnb/static/icons/apple-touch-icon-152x152-7b7c6444b63d8b6ebad9dae7169e5ed6.png" />
<link rel="apple-touch-icon" sizes="180x180"
	href="https://a0.muscache.com/airbnb/static/icons/apple-touch-icon-180x180-bcbe0e3960cd084eb8eaf1353cf3c730.png" />
<link rel="icon" sizes="192x192"
	href="https://a0.muscache.com/airbnb/static/icons/android-icon-192x192-c0465f9f0380893768972a31a614b670.png" />
<link rel="shortcut icon" sizes="76x76" type="image/x-icon"
	href="https://a0.muscache.com/airbnb/static/logotype_favicon-21cc8e6c6a2cca43f061d2dcabdf6e58.ico" />
<link rel="mask-icon"
	href="https://a0.muscache.com/airbnb/static/icons/airbnb-0611901eac33ccfa5e93d793a2e21f09.svg"
	color="#FF5A5F" />

	<script type="text/javascript">

	$(function(){
		$("#MagicCarpetSearchBar").on("submit",function(e){
			var tmpLocation = $("#lp-geocomplete").val();
			var tmpCheckIn = $("#datePickerCheckIn").val();
			var tmpCheckOut = $("#datePickerCheckOut").val();
				if(tmpLocation ==""){
					swal({					
						text:"여행지를 입력해 주세요",					
						icon:"warning",		
						buttons:[false,"확인"]
					}).then(function(isConfirm){
						return false;
					})
					
					
				}else if(tmpCheckIn==""){
					swal({					
						text:"체크인 날짜를 입력하세요",					
						icon:"warning",		
						buttons:[false,"확인"]
					}).then(function(isConfirm){
						return false;
					})
				}else if(tmpCheckOut==""){
					swal({					
						text:"체크아웃 날짜를 입력하세요",					
						icon:"warning",		
						buttons:[false,"확인"]
					}).then(function(isConfirm){
						return false;
					})
				}else{
					return true;
				}
				return false;
				//$("#MagicCarpetSearchBar").attr("action","searchList");
		})
	})
		/* function check(){
		var tmpLocation = $("#lp-geocomplete").val();
		var tmpCheckIn = $("#datePickerCheckIn").val();
		var tmpCheckOut = $("#datePickerCheckOut").val();
			if(tmpLocation ==""){
				console.log("1")
				
				swal({					
					text:"여행지를 입력해 주세요",					
					icon:"warning",		
					buttons:[false,"확인"]
				}).then(function(isConfirm){
					location.reload();
				})
				
				
			}else if(tmpCheckIn==""){
				alert("체크인 날짜를 입력하세요");
				return false;
			}else if(tmpCheckOut==""){
				alert("체크아웃 날짜를 입력하세요");
				return false;
			}else{
				$("#MagicCarpetSearchBar").attr("action","searchList");
				return true;
			} 
		} */
	</script>
<style data-aphrodite="data-aphrodite">
.ui-datepicker{ font-size: 12px; width: 290px; }



._e296pg {
	position: relative !important;
}



._1hf0dpr7 {
	padding-top: 0px !important;
	padding-bottom: 16px !important;
}

@media ( min-width : 744px) {
	._1hf0dpr7 {
		padding-top: 64px !important;
		padding-bottom: 24px !important;
	}
}

@media ( min-width : 1128px) {
	._1hf0dpr7 {
		background: #ffffff !important;
		border-radius: 4px !important;
		width: 508px !important;
		margin-bottom: 64px !important;
		padding: 32px !important;
	}
}

._1yim2mcp {
	font-size: 32px !important;
	line-height: 36px !important;
	letter-spacing: normal !important;
	font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
		Helvetica Neue, sans-serif !important;
	text-transform: undefined !important;
	color: #ffffff !important;
	padding-top: 6px !important;
	padding-bottom: 6px !important;
	font-weight: bold !important;
	margin: 0px !important;
	padding: 0px !important;
}

@media ( min-width : 744px) {
	._1yim2mcp {
		font-size: 32px !important;
		letter-spacing: normal !important;
		font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
			Helvetica Neue, sans-serif !important;
		text-transform: undefined !important;
		color: #ffffff !important;
		padding-top: 6px !important;
		padding-bottom: 6px !important;
		margin: 0px !important;
		padding: 0px !important;
		line-height: 36px !important;
	}
}

@media ( min-width : 1128px) {
	._1yim2mcp {
		font-size: 32px !important;
		letter-spacing: normal !important;
		font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
			Helvetica Neue, sans-serif !important;
		text-transform: undefined !important;
		color: #484848 !important;
		padding-top: 6px !important;
		padding-bottom: 6px !important;
		margin: 0px !important;
		padding: 0px !important;
		line-height: 36px !important;
	}
}

._1a3xhgk {
	font-size: 16px !important;
	line-height: 22px !important;
	letter-spacing: normal !important;
	font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
		Helvetica Neue, sans-serif !important;
	text-transform: undefined !important;
	color: #ffffff !important;
	padding-top: undefined !important;
	padding-bottom: undefined !important;
	width: 100% !important;
	margin-top: 8px !important;
}

@media ( min-width : 744px) {
	._1a3xhgk {
		font-size: 18px !important;
		line-height: 26px !important;
		letter-spacing: normal !important;
		font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
			Helvetica Neue, sans-serif !important;
		text-transform: undefined !important;
		color: #ffffff !important;
		padding-top: undefined !important;
		padding-bottom: undefined !important;
		margin-top: 4px !important;
	}
}

@media ( min-width : 1128px) {
	._1a3xhgk {
		font-size: 18px !important;
		line-height: 26px !important;
		letter-spacing: normal !important;
		font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
			Helvetica Neue, sans-serif !important;
		text-transform: undefined !important;
		color: #484848 !important;
		padding-top: undefined !important;
		padding-bottom: undefined !important;
		margin-top: 8px !important;
		margin-bottom: 8px !important;
	}
}

._slilk2 {
	background: #ffffff !important;
	border-radius: 4px !important;
}


.modelBox{
	position: relative;

	margin: 0 auto;
}

._ovebx1 {
	padding-left: 24px !important;
	padding-right: 24px !important;
	max-width: 1080px !important;
	width:50%;
	height: 50%;
	position:absolute;
	top: 200px;
	left: 0;
	bottom: 0;
	right: 0;
	margin: 0 auto;
}

@media ( min-width : 1128px) {
	._ovebx1 {
		margin: 0 auto !important;
		position: relative !important;
	}
}

._14i3z6h {
	color: inherit !important;
	font-size: 1em !important;
	font-weight: inherit !important;
	line-height: inherit !important;
	margin: 0px !important;
	padding: 0px !important;
}

._14i3z6h:focus {
	outline: 0px !important;
}

._izemrk6 {
	font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
		Helvetica Neue, sans-serif !important;
	margin: 0px !important;
	word-wrap: break-word !important;
	font-size: 12px !important;
	font-weight: 800 !important;
	line-height: 1.3333333333333333em !important;
	letter-spacing: 0.08333333333333333em !important;
	color: #484848 !important;
}

._gor68n {
	position: relative !important;
	z-index: 1 !important;
}

._9hxttoo {
	display: block !important;
	width: 100% !important;
}

._1m8bb6v {
	position: absolute !important;
	display: block !important;
	border: 0px !important;
	margin: -1px !important;
	padding: 0px !important;
	height: 1px !important;
	width: 1px !important;
	clip: rect(0, 0, 0, 0) !important;
	overflow: hidden !important;
}

._uvunks8 {
	font-size: 16px !important;
	line-height: 24px !important;
	letter-spacing: normal !important;
	font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
		Helvetica Neue, sans-serif !important;
	text-transform: undefined !important;
	color: #484848 !important;
	padding-top: undefined !important;
	padding-bottom: undefined !important;
	border-width: 1px !important;
	border-style: solid !important;
	border-color: #EBEBEB !important;
	border-radius: 4px !important;
	background-color: #ffffff !important;
	position: relative !important;
	z-index: 0 !important;
	margin-bottom: 0px !important;
	margin-top: 0px !important;
	margin-left: 0px !important;
	margin-right: 0px !important;
	display: block !important;
	width: 100% !important;
}

@
supports (--custom: properties ){ . _uvunks8 {
	font-size: var(- -font-form-element-font-size, 16px) !important;
	line-height: var(- -font-form-element-line-height, 24px) !important;
	letter-spacing: var(- -font-form-element-letter-spacing, normal)
		!important;
	font-family: var(- -font-form-element-font-family, Circular,
		-apple-system, BlinkMacSystemFont, Roboto, Helvetica Neue,
		sans-serif) !important;
	text-transform: var(- -font-form-element-text-transform, undefined)
		!important;
	color: var(- -font-form-element-color, #484848) !important;
	padding-top: var(- -font-form-element-padding-top, undefined) !important;
	padding-bottom: var(- -font-form-element-padding-bottom, undefined)
		!important;
	border-width: var(- -border-form-element-border-width, 1px) !important;
	border-color: var(- -color-input-border, #EBEBEB) !important;
	border-radius: var(- -border-form-element-border-radius, 4px) !important;
	background-color: var(- -color-input-background, #ffffff) !important;
}

}
._178faes {
	overflow: hidden !important;
	position: relative !important;
}

._1mcoxpnl {
	font-size: 16px !important;
	line-height: 24px !important;
	letter-spacing: normal !important;
	font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
		Helvetica Neue, sans-serif !important;
	text-transform: undefined !important;
	color: #484848 !important;
	padding-top: 11px !important;
	padding-bottom: 11px !important;
	background-color: transparent !important;
	border: 0px !important;
	padding-left: 11px !important;
	padding-right: 11px !important;
	width: 100% !important;
	margin: 0px !important;
	font-weight: 600 !important;
	text-overflow: ellipsis !important;
}

._1mcoxpnl:focus {
	outline: none !important;
}

._1mcoxpnl::-ms-clear {
	display: none !important;
}

._1mcoxpnl::-webkit-input-placeholder {
	color: #484848 !important;
	opacity: 1 !important;
}

._1mcoxpnl::-moz-placeholder {
	color: #484848 !important;
	opacity: 1 !important;
}

._1mcoxpnl:-moz-placeholder {
	color: #484848 !important;
	opacity: 1 !important;
}

._1mcoxpnl:-ms-input-placeholder {
	color: #484848 !important;
	opacity: 1 !important;
}

._1mcoxpnl::placeholder {
	color: #484848 !important;
	opacity: 1 !important;
}

@
supports (--custom: properties ){ . _1mcoxpnl {
	font-size: var(- -font-form-element-font-size, 16px) !important;
	line-height: var(- -font-form-element-line-height, 24px) !important;
	letter-spacing: var(- -font-form-element-letter-spacing, normal)
		!important;
	font-family: var(- -font-form-element-font-family, Circular,
		-apple-system, BlinkMacSystemFont, Roboto, Helvetica Neue,
		sans-serif) !important;
	text-transform: var(- -font-form-element-text-transform, undefined)
		!important;
	color: var(- -font-form-element-color, #484848) !important;
	padding-top: var(- -spacing-form-element-vertical, 11px) !important;
	padding-bottom: var(- -spacing-form-element-vertical, 11px) !important;
	background-color: var(- -color-clear, transparent) !important;
	padding-left: var(- -spacing-form-element-horizontal, 11px) !important;
	padding-right: var(- -spacing-form-element-horizontal, 11px) !important;
	font-weight: var(- -font-book-font-weight, 600) !important;
}

._1mcoxpnl::-webkit-input-placeholder {
	color: var(- -font-form-input-color, #484848) !important;
}

._1mcoxpnl::-moz-placeholder {
	color: var(- -font-form-input-color, #484848) !important;
}

._1mcoxpnl:-moz-placeholder {
	color: var(- -font-form-input-color, #484848) !important;
}

._1mcoxpnl:-ms-input-placeholder {
	color: var(- -font-form-input-color, #484848) !important;
}

._1mcoxpnl::placeholder {
	color: var(- -font-form-input-color, #484848) !important;
}

}


._2h22gn {
	margin-left: -8px !important;
	margin-right: -8px !important;
}

._2h22gn:before {
	content: " " !important;
	display: table !important;
}

._2h22gn:after {
	content: " " !important;
	display: table !important;
	clear: both !important;
}

._iq8x9is {
	padding-left: 8px !important;
	padding-right: 8px !important;
	min-height: 1px !important;
	position: relative !important;
	width: 50% !important;
	float: left !important;
}

._rin72m {
	background: transparent !important;
	border: 0px !important;
	cursor: pointer !important;
	display: block !important;
	padding: 0px !important;
}

._18nbudra {
	font-size: 16px !important;
	line-height: 24px !important;
	letter-spacing: normal !important;
	font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
		Helvetica Neue, sans-serif !important;
	text-transform: undefined !important;
	color: #484848 !important;
	padding-top: 11px !important;
	padding-bottom: 11px !important;
	background-color: transparent !important;
	border: 0px !important;
	padding-left: 11px !important;
	padding-right: 11px !important;
	width: 100% !important;
	margin: 0px !important;
	font-weight: 600 !important;
}

._18nbudra:focus {
	outline: none !important;
}

._18nbudra::-ms-clear {
	display: none !important;
}

._18nbudra::-webkit-input-placeholder {
	color: #767676 !important;
	opacity: 1 !important;
}

._18nbudra::-moz-placeholder {
	color: #767676 !important;
	opacity: 1 !important;
}

._18nbudra:-moz-placeholder {
	color: #767676 !important;
	opacity: 1 !important;
}

._18nbudra:-ms-input-placeholder {
	color: #767676 !important;
	opacity: 1 !important;
}

._18nbudra::placeholder {
	color: #767676 !important;
	opacity: 1 !important;
}

@
supports (--custom: properties ){ . _18nbudra {
	font-size: var(- -font-form-element-font-size, 16px) !important;
	line-height: var(- -font-form-element-line-height, 24px) !important;
	letter-spacing: var(- -font-form-element-letter-spacing, normal)
		!important;
	font-family: var(- -font-form-element-font-family, Circular,
		-apple-system, BlinkMacSystemFont, Roboto, Helvetica Neue,
		sans-serif) !important;
	text-transform: var(- -font-form-element-text-transform, undefined)
		!important;
	color: var(- -font-form-element-color, #484848) !important;
	padding-top: var(- -spacing-form-element-vertical, 11px) !important;
	padding-bottom: var(- -spacing-form-element-vertical, 11px) !important;
	background-color: var(- -color-clear, transparent) !important;
	padding-left: var(- -spacing-form-element-horizontal, 11px) !important;
	padding-right: var(- -spacing-form-element-horizontal, 11px) !important;
	font-weight: var(- -font-book-font-weight, 600) !important;
}

._18nbudra::-webkit-input-placeholder {
	color: var(- -color-placeholder, #767676) !important;
}

._18nbudra::-moz-placeholder {
	color: var(- -color-placeholder, #767676) !important;
}

._18nbudra:-moz-placeholder {
	color: var(- -color-placeholder, #767676) !important;
}

._18nbudra:-ms-input-placeholder {
	color: var(- -color-placeholder, #767676) !important;
}

._18nbudra::placeholder {
	color: var(- -color-placeholder, #767676) !important;
}

}
._wlf6154 {
	font-size: 16px !important;
	line-height: 24px !important;
	letter-spacing: normal !important;
	font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
		Helvetica Neue, sans-serif !important;
	text-transform: undefined !important;
	color: #484848 !important;
	padding-top: undefined !important;
	padding-bottom: undefined !important;
	position: relative !important;
	background-color: #ffffff !important;
	border-width: 1px !important;
	border-style: solid !important;
	border-color: #EBEBEB !important;
	border-radius: 4px !important;
	margin-bottom: 8px !important;
	display: block !important;
	width: 100% !important;
}

@
supports (--custom: properties ){ . _wlf6154 {
	font-size: var(- -font-form-element-font-size, 16px) !important;
	line-height: var(- -font-form-element-line-height, 24px) !important;
	letter-spacing: var(- -font-form-element-letter-spacing, normal)
		!important;
	font-family: var(- -font-form-element-font-family, Circular,
		-apple-system, BlinkMacSystemFont, Roboto, Helvetica Neue,
		sans-serif) !important;
	text-transform: var(- -font-form-element-text-transform, undefined)
		!important;
	color: var(- -font-form-element-color, #484848) !important;
	padding-top: var(- -font-form-element-padding-top, undefined) !important;
	padding-bottom: var(- -font-form-element-padding-bottom, undefined)
		!important;
	background-color: var(- -color-input-background, #ffffff) !important;
	border-width: var(- -border-form-element-border-width, 1px) !important;
	border-color: var(- -color-input-border, #EBEBEB) !important;
	border-radius: var(- -border-form-element-border-radius, 4px) !important;
	margin-bottom: var(- -spacing-form-element-margin-bottom, 8px)
		!important;
}

}
._y9ev9r {
	overflow: hidden !important;
}

._bwyiq2l {
	-webkit-appearance: none !important;
	-moz-appearance: none !important;
	appearance: none !important;
	font-size: 16px !important;
	line-height: 24px !important;
	letter-spacing: normal !important;
	font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
		Helvetica Neue, sans-serif !important;
	text-transform: undefined !important;
	color: #484848 !important;
	padding-top: 11px !important;
	padding-bottom: 11px !important;
	font-weight: normal !important;
	background-color: transparent !important;
	border: none !important;
	border-radius: 0px !important;
	padding-left: 11px !important;
	padding-right: 40px !important;
	margin: 0px !important;
	text-indent: 0px !important;
	height: unset !important;
	display: block !important;
	width: 100% !important;
}

._bwyiq2l::-ms-expand {
	display: none !important;
}

._bwyiq2l:focus {
	outline: none !important;
}

@
supports (--custom: properties ){ . _bwyiq2l {
	font-size: var(- -font-form-element-font-size, 16px) !important;
	line-height: var(- -font-form-element-line-height, 24px) !important;
	letter-spacing: var(- -font-form-element-letter-spacing, normal)
		!important;
	font-family: var(- -font-form-element-font-family, Circular,
		-apple-system, BlinkMacSystemFont, Roboto, Helvetica Neue,
		sans-serif) !important;
	text-transform: var(- -font-form-element-text-transform, undefined)
		!important;
	color: var(- -font-form-element-color, #484848) !important;
	padding-top: var(- -spacing-form-element-vertical, 11px) !important;
	padding-bottom: var(- -spacing-form-element-vertical, 11px) !important;
	font-weight: var(- -font-light-font-weight, normal) !important;
	background-color: var(- -color-clear, transparent) !important;
	padding-left: var(- -spacing-form-element-horizontal, 11px) !important;
	padding-right: var(- -spacing-select-arrow, 40px) !important;
}

}
._1idvclr {
	position: absolute !important;
	top: 16px !important;
	right: 16px !important;
	line-height: 0 !important;
	pointer-events: none !important;
}

@
supports (--custom: properties ){ . _1idvclr {
	top: var(- -spacing-select-arrow-margin-top, 16px) !important;
	right: var(- -spacing-select-arrow-margin-outside, 16px) !important;
}

}
._1bugpqdv {
	font-size: 16px !important;
	line-height: 24px !important;
	letter-spacing: normal !important;
	font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
		Helvetica Neue, sans-serif !important;
	text-transform: undefined !important;
	color: #484848 !important;
	padding-top: undefined !important;
	padding-bottom: undefined !important;
	position: relative !important;
	background-color: #ffffff !important;
	border-width: 1px !important;
	border-style: solid !important;
	border-color: #EBEBEB !important;
	border-radius: 4px !important;
	display: block !important;
	width: 100% !important;
	margin-bottom: 0px !important;
	margin-top: 0px !important;
	margin-left: 0px !important;
	margin-right: 0px !important;
}

@
supports (--custom: properties ){ . _1bugpqdv {
	font-size: var(- -font-form-element-font-size, 16px) !important;
	line-height: var(- -font-form-element-line-height, 24px) !important;
	letter-spacing: var(- -font-form-element-letter-spacing, normal)
		!important;
	font-family: var(- -font-form-element-font-family, Circular,
		-apple-system, BlinkMacSystemFont, Roboto, Helvetica Neue,
		sans-serif) !important;
	text-transform: var(- -font-form-element-text-transform, undefined)
		!important;
	color: var(- -font-form-element-color, #484848) !important;
	padding-top: var(- -font-form-element-padding-top, undefined) !important;
	padding-bottom: var(- -font-form-element-padding-bottom, undefined)
		!important;
	background-color: var(- -color-input-background, #ffffff) !important;
	border-width: var(- -border-form-element-border-width, 1px) !important;
	border-color: var(- -color-input-border, #EBEBEB) !important;
	border-radius: var(- -border-form-element-border-radius, 4px) !important;
	margin-bottom: var(- -spacing-form-element-margin-bottom, 8px)
		!important;
}

}
._taglxzq {
	display: inline-block !important;
	margin: 0px !important;
	position: relative !important;
	text-align: center !important;
	text-decoration: none !important;
	-webkit-transition-property: background, border-color, color !important;
	-moz-transition-property: background, border-color, color !important;
	transition-property: background, border-color, color !important;
	-webkit-transition-duration: 0.2s !important;
	transition-duration: 0.2s !important;
	-webkit-transition-timing-function: ease-out !important;
	transition-timing-function: ease-out !important;
	cursor: pointer !important;
	border-radius: 4px !important;
	width: 100% !important;
	font-size: 16px !important;
	line-height: 24px !important;
	letter-spacing: normal !important;
	font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
		Helvetica Neue, sans-serif !important;
	text-transform: undefined !important;
	padding-top: 10px !important;
	padding-bottom: 10px !important;
	font-weight: 800 !important;
	border-width: 2px !important;
	border-style: solid !important;
	padding-left: 22px !important;
	padding-right: 22px !important;
	min-width: 71.19349550499538px !important;
	box-shadow: none !important;
	background: #FF5A5F !important;
	border-color: transparent !important;
	color: #ffffff !important;
}

._taglxzq:disabled {
	background: rgba(255, 90, 95, 0.3) !important;
	border-color: transparent !important;
	color: #ffffff !important;
}

._taglxzq::-moz-focus-inner {
	border: 0px !important;
	padding: 0px !important;
	margin: 0px !important;
}

._taglxzq:focus::-moz-focus-inner {
	border: 1px dotted #000000 !important;
}

._taglxzq:hover {
	background: #FF5A5F !important;
	border-color: transparent !important;
	color: #ffffff !important;
}

._taglxzq:active {
	background: #df3c47 !important;
	border-color: transparent !important;
	color: #ffffff !important;
}

@
supports (--custom: properties ){ . _taglxzq {
	border-radius: var(- -border-button-border-radius, 4px) !important;
	font-size: var(- -font-button-font-size, 16px) !important;
	line-height: var(- -font-button-line-height, 24px) !important;
	letter-spacing: var(- -font-button-letter-spacing, normal) !important;
	font-family: var(- -font-button-font-family, Circular, -apple-system,
		BlinkMacSystemFont, Roboto, Helvetica Neue, sans-serif) !important;
	text-transform: var(- -font-button-text-transform, undefined) !important;
	padding-top: var(- -spacing-button-vertical, 10px) !important;
	padding-bottom: var(- -spacing-button-vertical, 10px) !important;
	font-weight: var(- -font-bold-font-weight, 800) !important;
	border-width: var(- -border-button-border-width, 2px) !important;
	padding-left: var(- -spacing-button-horizontal, 22px) !important;
	padding-right: var(- -spacing-button-horizontal, 22px) !important;
	box-shadow: var(- -shadow-button-level0-box-shadow, none) !important;
	background: var(- -color-buttons-primary-color, #FF5A5F) !important;
	border-color: var(- -color-buttons-primary-border, transparent)
		!important;
	color: var(- -color-buttons-primary-text, #ffffff) !important;
}

._taglxzq:disabled {
	background: var(- -color-buttons-primary-disabled-color, rgba(255, 90, 95, 0.3))
		!important;
	border-color: var(- -color-buttons-primary-disabled-border, transparent)
		!important;
	color: var(- -color-buttons-primary-disabled-text, #ffffff) !important;
}

._taglxzq:hover {
	background: var(- -color-buttons-primary-hover-color, #FF5A5F)
		!important;
	border-color: var(- -color-buttons-primary-hover-border, transparent)
		!important;
	color: var(- -color-buttons-primary-hover-text, #ffffff) !important;
}

._taglxzq:active {
	background: var(- -color-buttons-primary-active-color, #df3c47)
		!important;
	border-color: var(- -color-buttons-primary-active-border, transparent)
		!important;
	color: var(- -color-buttons-primary-active-text, #ffffff) !important;
}

}
._ftj2sg4 {
	font-size: 16px !important;
	line-height: 24px !important;
	letter-spacing: normal !important;
	font-family: Circular, -apple-system, BlinkMacSystemFont, Roboto,
		Helvetica Neue, sans-serif !important;
	text-transform: undefined !important;
	color: inherit !important;
	padding-top: undefined !important;
	padding-bottom: undefined !important;
}

@
supports (--custom: properties ){ . _ftj2sg4 {
	font-size: var(- -font-button-font-size, 16px) !important;
	line-height: var(- -font-button-line-height, 24px) !important;
	letter-spacing: var(- -font-button-letter-spacing, normal) !important;
	font-family: var(- -font-button-font-family, Circular, -apple-system,
		BlinkMacSystemFont, Roboto, Helvetica Neue, sans-serif) !important;
	text-transform: var(- -font-button-text-transform, undefined) !important;
	padding-top: var(- -font-button-padding-top, undefined) !important;
	padding-bottom: var(- -font-button-padding-bottom, undefined) !important;
}

}


@media ( max-width : 1439px) {
}



@
keyframes keyframe_1vunhnd {
	from {opacity: 0.1;
}

to {
	opacity: 0.3;
}

}
._wylrqg {
	-webkit-animation-direction: alternate !important;
	animation-direction: alternate !important;
	-webkit-animation-duration: 1s !important;
	animation-duration: 1s !important;
	-webkit-animation-fill-mode: forwards !important;
	animation-fill-mode: forwards !important;
	-webkit-animation-iteration-count: infinite !important;
	animation-iteration-count: infinite !important;
	-webkit-animation-name: keyframe_1vunhnd !important;
	animation-name: keyframe_1vunhnd !important;
	-webkit-animation-timing-function: ease-in-out !important;
	animation-timing-function: ease-in-out !important;
	background-color: currentColor !important;
	display: inline-block !important;
	position: relative !important;
}


</style>
</head>
<body>

	<div class="modelBox" style="background-image:url(${contextPath}/img/search-back.jpg); background-repeat:no-repeat; background-size:100%; width:80%; height:900px;">
		<div class="_ovebx1" style="background-color: transparent;">
			<div class="_1hf0dpr7">
				<div class="_1yim2mcp">
					<h1 tabindex="-1" class="_14i3z6h">다님에서 숙소를 찾아보세요</h1>
				</div>
				<div>
					<div class="_1a3xhgk">혼자 하는 여행에 적합한 개인실부터 여럿이 함께하는 여행에 좋은 집
						전체 숙소까지, 다님에서 확인하세요</div>
				</div>
				<div>
					<div class="_slilk2">
						<form id="MagicCarpetSearchBar" action="searchList"
							data-arrive-module-id="magicCarpetSearchBar" >
							<div>
								<div style="margin-top: 20px; margin-bottom: 20px;">
									<div data-arrive-module-id="mc-autocomplete-module">
										<div style="margin-bottom: 8px;">
											<span class="_izemrk6">목적지</span>
										</div>
										<div data-arrive-module-id="auto-complete">
											<div class="_gor68n">
												<div>
													<div class="_e296pg">
														<div class="_9hxttoo">
															<label class="_1m8bb6v" for="lp-geocomplete">위치</label>
															<div dir="ltr">
																<div class="_uvunks8">
																	<div class="_178faes">
																		<input type="text" autocomplete="off"
																			aria-autocomplete="list" aria-expanded="false"
																			aria-haspopup="true" class="_1mcoxpnl"
																			id="lp-geocomplete" name="city"
																			placeholder="여행지를 입력하세요">
																		<!-- <div data-veloute="undefined__clearButton"
																			class="_1cyay8zu">
																			<div class="_q2vo16">
																				<button class="_1cxwdct" type="button">
																					<svg viewBox="0 0 24 24" role="img"
																						aria-label="Clear Input" focusable="false"
																						style="height: 12px; width: 12px; display: block; fill: currentcolor;">
																					<path
																							d="m23.25 24c-.19 0-.38-.07-.53-.22l-10.72-10.72-10.72 10.72c-.29.29-.77.29-1.06 0s-.29-.77 0-1.06l10.72-10.72-10.72-10.72c-.29-.29-.29-.77 0-1.06s.77-.29 1.06 0l10.72 10.72 10.72-10.72c.29-.29.77-.29 1.06 0s .29.77 0 1.06l-10.72 10.72 10.72 10.72c.29.29.29.77 0 1.06-.15.15-.34.22-.53.22"
																							fill-rule="evenodd"></path></svg>
																				</button>
																			</div>
																		</div> -->
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div style="margin-top: 20px; margin-bottom: 20px;">
								<div data-arrive-id="datePicker">
									<div class="_e296pg">
										<div style="margin-top: 8px;">
											<div class="_2h22gn">
												<div class="_iq8x9is">
													<div>
														<div style="margin-bottom: 8px;">
															<label class="_rin72m" for="checkin_input"><span
																class="_izemrk6">체크인</span></label>
														</div>
														<div data-veloute="moweb_datepicker_checkin_input" class="input-group.date">
															<div class="_9hxttoo">
																<div dir="ltr">
																	<div class="_uvunks8">
																		<div class="_178faes">
																			<input type="text" class="_18nbudra"
																				data-veloute="checkin_input" id="datePickerCheckIn"
																				name="startDate" placeholder="년/월/일" value=""
																				readonly="readonly">
																				<script>
																				$('#datePickerCheckIn').datetimepicker({
																					language:  'ko',
																					minDate: 0,
																			        weekStart: 1,
																			       
																					autoclose: 1,
																					todayHighlight: 1,
																					startView: 2,
																					minView: 2,
																					forceParse: 0,
																					onSelect:function(){
																						
																					}
																			    });
																			</script>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="_iq8x9is">
													<div>
														<div style="margin-bottom: 8px;">
															<label class="_rin72m" for="checkout_input"><span
																class="_izemrk6">체크아웃</span></label>
														</div>
														<div data-veloute="moweb_datepicker_checkout_input" class="input-group.date">
															<div class="_9hxttoo">
																<div dir="ltr">
																	<div class="_uvunks8">
																		<div class="_178faes">
																			<input type="text" class="_18nbudra"
																				data-veloute="checkout_input" id="datePickerCheckOut"
																				name="endDate" placeholder="년/월/일" value=""
																				readonly="readonly">
																				<script type="text/javascript">
																				$("#datePickerCheckOut").datetimepicker({
																					language:  'ko',
																					minDate: 0,
																			        weekStart: 1,
																					autoclose: 1,
																					todayHighlight: 1,
																					startView: 2,
																					minView: 2,
																					forceParse: 0,
																					onSelect:function(){
																						
																					}
																				});
																				$("input[name=startDate]").on("change",function(){
																					 var dateFormat = $("input[name=startDate]").val();
																					 var day = dateFormat.substring(0,10);
																					 $("input[name=startDate]").val(day);
																						
																				 })
																				 $("input[name=endDate]").on("change",function(){
																					 var dateFormat1 = $("input[name=endDate]").val();
																					 var day1 = dateFormat1.substring(0,10);
																					 $("input[name=endDate]").val(day1);
																				 })
																				</script>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div style="margin-top: 20px; margin-bottom: 24px;">
								<div id="lp-guestpicker">
									<div class="_2h22gn">
										<div class="_iq8x9is">
											<div style="margin-bottom: 8px;">
												<label class="_rin72m" for="adults"><span
													class="_izemrk6">인원</span></label>
											</div>
											<div class="_9hxttoo">
												<div class="_wlf6154">
													<div class="_y9ev9r">
														<select id="adults" name="adults" class="_bwyiq2l"
															data-vars-select-name="adults"><option value="1">
																1명</option>
															<option value="2">2명</option>
															<option value="3">3명</option>
															<option value="4">4명</option>
															<option value="5">5명</option>
															<option value="6">6명</option>
															<option value="7">7명</option>
															<option value="8">8명</option>
															<option value="9">9명</option>
															<option value="10">10명</option>
															<option value="11">11명</option>
															<option value="12">12명</option>
															<option value="13">13명</option>
															<option value="14">14명</option>
															<option value="15">15명</option>
															</select>
													</div>
													<span class="_1idvclr"><svg viewBox="0 0 18 18"
															role="presentation" aria-hidden="true" focusable="false"
															style="height: 16px; width: 16px; display: block; fill: rgb(72, 72, 72);">
														<path
																d="m16.29 4.3a1 1 0 1 1 1.41 1.42l-8 8a1 1 0 0 1 -1.41 0l-8-8a1 1 0 1 1 1.41-1.42l7.29 7.29z"
																fill-rule="evenodd"></path></svg></span>
												</div>
											</div>
										</div>
										<!-- <div class="_iq8x9is">
											<div style="margin-bottom: 8px;">
												<label class="_rin72m" for="children"><span
													class="_izemrk6">어린이</span></label>
											</div>
											<div class="_9hxttoo">
												<div class="_1bugpqdv">
													<div class="_y9ev9r">
														<select id="children" name="children" class="_bwyiq2l"
															data-vars-select-name="children"><option
																value="0">어린이 0명</option>
															<option value="1">어린이 1명</option>
															<option value="2">어린이 2명</option>
															<option value="3">어린이 3명</option>
															<option value="4">어린이 4명</option>
															<option value="5">어린이 5명</option></select>
													</div>
													<span class="_1idvclr"><svg viewBox="0 0 18 18"
															role="presentation" aria-hidden="true" focusable="false"
															style="height: 16px; width: 16px; display: block; fill: rgb(72, 72, 72);">
														<path
																d="m16.29 4.3a1 1 0 1 1 1.41 1.42l-8 8a1 1 0 0 1 -1.41 0l-8-8a1 1 0 1 1 1.41-1.42l7.29 7.29z"
																fill-rule="evenodd"></path></svg></span>
												</div>
											</div>
										</div> -->
									</div>
								</div>
							</div>
							<div id="lp-search-button"
								data-veloute="search_bar_small_search_button">
								<div>
									<button type="submit" id="btnSubmit" class="_taglxzq" aria-busy="false" >
										<span class="_ftj2sg4">검색</span>
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="raonChat" class="chat_box" style="display: none;">
	<input id="user" type="hidden" value="">
	<input id="target" type="hidden" value="">
	<input id="roomnum" type="hidden" value="">
	<div class="msg_box" style="right: 280px">
		<div class="msg_head">
			<a id="msg_name"></a>
			<div class="close">x</div>
		</div>
		<div class="msg_wrap">
			<div class="msg_body">
				<div class="msg_push"></div>
			</div>
			<div class="msg_footer">
				<textarea class="msg_input" rows="2"></textarea>
			</div>
		</div>
	</div>
</div>

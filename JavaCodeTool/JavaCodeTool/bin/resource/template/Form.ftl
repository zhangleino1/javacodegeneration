<form id="Form${domainName}" method="post">
	<div class="FormDiv">
	<#list list as map>
		<div class="DivRow">
			<div class="DivCollTitle" style="width: 150px;">${map.REMARKS}</div>
			<div class="DivColl" style="width: 150px">
				<input id="${map.COLUMN_NAME}" name="${map.COLUMN_NAME}" class="easyui-validatebox" />
			</div>
		</div>
	</#list>
	</div>
</form>

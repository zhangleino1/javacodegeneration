<form id="View${domainName}" method="post">
	<div class="FormDiv">
	<#list list as map>
		<div class="DivRow">
			<div class="DivCollTitle" style="width: 140px;">${map.REMARKS}</div>
			<div class="DivCollText" style="width: 200px" id="${map.COLUMN_NAME}"></div>
		</div>
	</#list>
	</div>
</form>

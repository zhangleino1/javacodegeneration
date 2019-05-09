var ${domainName} = new Object;

${domainName}.RowJson = {
<#list list as map>"${map.COLUMN_NAME}":null<#if map_has_next>,</#if> </#list>
};
// 初始化
${domainName}.Initialization = function() {
	${domainName}.InitializationControls();
	${domainName}.InitializationDataGrid();
	${domainName}.InitializationToolbar();
	${domainName}.InitializationPagination();

	${domainName}.LoadDataGridData(1);
};

${domainName}.InitializationControls = function() {

	var h = $('#LayoutCenter').height() - 50;
	$('#MainContent').height(h);
	//webcontroller.BindWrAddvByFid($('#addvcd1'), webcontroller.User.ADDVCD);

};

${domainName}.Resize = function() {

	var h = $('#LayoutCenter').height() - 50;
	$('#MainContent').height(h);
	$('#${domainName}DataGrid').datagrid("resize");
};

${domainName}.InitializationDataGrid = function() {
	var columns = [ [ 
	<#list list as map>
	{
		field : '${map.COLUMN_NAME}',
		title : '${map.REMARKS}',
		width : 60,
		align : webcontroller.Configs.Align_String
	}<#if map_has_next>,</#if>
	</#list>
	] ];
	webcontroller.InitializationDataGrid('${domainName}DataGrid',
			'${tableComment}列表', columns);

};

 // 加载DataGrid分页控件
${domainName}.InitializationPagination = function() {
	var p = $('#${domainName}DataGrid').datagrid('getPager');
	$(p).pagination({
		pageNumber : 1,
		pageSize : webcontroller.Configs.PageSize,
		showPageList : false,
		onRefresh : function(pageNumber, pageSize) {
			// 刷新
			${domainName}.LoadDataGridData(pageNumber);
		},
		onSelectPage : function(pageNumber, pageSize) {
			// 换页
			${domainName}.LoadDataGridData(pageNumber);
		}
	});
};

// 初始化DataGrid工具栏
${domainName}.InitializationToolbar = function() {
	webcontroller.BindDatagridToolbarItemSearch(
			$('#${domainName}DataGrid'), webcontroller.User.DefaultPageID);
};

//  添加
${domainName}.NewDialog = function() {

	var btns = [];
	btns[btns.length] = {
		text : '保存',
		iconCls : 'icon-ok',
		handler : function() {
			${domainName}.OnAddEvent();
		}
	};
	btns[btns.length] = {
		text : '取消',
		iconCls : 'icon-cancel',
		handler : function() {
			$('#WepAppAllDialog').dialog('close');
		}
	};

	webcontroller.WepAppAllDialog('添加', 450, 350,
			'${domainName}_Form.html', btns, function() {
				$('#Form${domainName}').form('clear');
			//	${domainName}.InitFormPage.BindWQByCode($('#wqa'),'ShuiZhiLeiBie');
			//	${domainName}.InitFormPage.BindWQByCode($('#wqk'),'ShuiZhiLeiBie');
			//	${domainName}.InitFormPage.BindWQByCode($('#ns'),'YingYangZhuangTai');
				
			});
};

// 修改
${domainName}.EditDialog = function() {
	// 返回所有选中的行，当没有选中的记录时，将返回空数组。
	var selectRows = $('#${domainName}DataGrid').datagrid('getSelections');
	if (selectRows.length > 1) {

		$.messager.alert('提示', '修改时只能选择单行，您现在选择了请选了 ' + selectRows.length
				+ ' 行！', 'info');


		return;
	}
	var row = $('#${domainName}DataGrid').datagrid('getSelected');
	if (row) {
		var btns = [];
		btns[btns.length] = {
			text : '保存',
			iconCls : 'icon-ok',
			handler : function() {
				${domainName}.OnModifyEvent();
			}
		};
		btns[btns.length] = {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$('#WepAppAllDialog').dialog('close');
			}
		};

		webcontroller.WepAppAllDialog('修改', 450, 350,
				'${domainName}_Form.html', btns, function() {
					$('#Form${domainName}').form('clear');
					$('#Form${domainName}').form('load', row);
				//	${domainName}.InitFormPage.BindWQByCode($('#wqa'),'ShuiZhiLeiBie',row.wqa);
				//	${domainName}.InitFormPage.BindWQByCode($('#wqk'),'ShuiZhiLeiBie',row.wqk);
				//	${domainName}.InitFormPage.BindWQByCode($('#ns'),'YingYangZhuangTai',row.ns);
					
				});
	} else {
		$.messager.alert('提示', '请选择要 修改 数据行！', 'info');
	}
};
/ 初始化Form页面控件
${domainName}.InitFormPage = {
		BindFName : function(addvcd) {
			// 行政区
			webcontroller.BindWrAddvByFid($('#addvcd'), webcontroller.User.ADDVCD,
					addvcd);

		}
};

// 查看
${domainName}.ViewDialog = function() {
	var row = $('#${domainName}DataGrid').datagrid('getSelected');
	if (row) {
		var btns = [];
		btns[btns.length] = {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$('#WepAppAllDialog').dialog('close');
			}
		};

		webcontroller.WepAppAllDialog('${tableComment}', 450, 350,
				'WaterFunction/Lakewqses/${domainName}_View.html', btns, function() {
					$('#View${domainName}').form('loadtodiv', row);
				});
	} else {
		$.messager.alert('提示', '请选择要 查看 数据行！', 'info');
	}
};

// 删除
${domainName}.RemoveDialog = function() {
	var rows = $('#${domainName}DataGrid').datagrid('getSelections');

	var ids = "";
	for ( var i = 0; i < rows.length; i++) {
		if (i == 0) {
			ids = "'" + rows[i].id + "'";
		} else {
			ids = ids + ",'" + rows[i].id + "'";
		}
	}

	if (rows.length > 0) {
		var confirmMsg =  '你确定要删除这【' + rows.length + '】行数据吗？';
		$.messager.confirm('消息', confirmMsg, function(r) {
			if (r) {
				webcontroller.SendToServer('I${domainName}Svc', 'del${domainName}', [ {
					"type" : "string",
					"name" : "ids",
					"value" : ids
				} ], function(oresp, oreq) {
					${domainName}.LoadDataGridData(1);
					webcontroller.MessageShow('删除成功！');
				}, function(oresp, oreq) {
					$.messager.alert("提示", "删除失败！", 'info');
				});
			}
		});
	} else {
		$.messager.alert('提示', '请选择要 删除 数据行！', 'info');
	}
};
// 娣诲姞
${domainName}.OnAddEvent = function() {
	if ($('#Form${domainName}').form('validate')) {
		<#list list as map>
		${domainName}.RowJson.${map.COLUMN_NAME} = $('#${map.COLUMN_NAME}').val();
		</#list>
		webcontroller.SendToServer('I${domainName}Svc', 'add${domainName}', [ {
			"name" : "item",
			"type" : "string",
			"value" : $.toJSON(${domainName}.RowJson)
		} ], function(oresp, oreq) {
			webcontroller.CloseDialog('保存成功！');
			// 重载的是当前页的记录而非第一页
			${domainName}.LoadDataGridData(1);
		}, function(oresp, oreq) {
			$.messager.alert("提示", oresp.RespHeader.ErrorMsg, 'info');
		});
	} else {
		$.messager.alert("提示", "验证未通过！", 'info');
	}
};

// 修改
${domainName}.OnModifyEvent = function() {
	var row = $('#${domainName}DataGrid').datagrid('getSelected');

	if ($('#Form${domainName}').form('validate')) {
		${domainName}.RowJson.id = row.id;
		<#list list as map>
		${domainName}.RowJson.${map.COLUMN_NAME} = $('#${map.COLUMN_NAME}').val();
		</#list>
		webcontroller.SendToServer('I${domainName}Svc', 'update${domainName}', [ {
			"name" : "item",
			"type" : "string",
			"value" : $.toJSON(${domainName}.RowJson)
		} ], function(oresp, oreq) {
			webcontroller.CloseDialog('保存成功！');
			${domainName}.LoadDataGridData(1);
		}, function(oresp, oreq) {
			$.messager.alert("提示", oresp.RespHeader.ErrorMsg, 'info');
		});
		${domainName}.RowJson.id=null;
	} else {
		$.messager.alert("提示", "验证未通过！", "info");
	}
};

${domainName}.LoadDataGridData = function(pageNumber) {
	${domainName}.LoadData(pageNumber, "");
};
// 查询
${domainName}.search = function() {
	var time1 = "";
	${domainName}.LoadData(1, time1);
};

// 加载数据
${domainName}.LoadData = function(pageNumber, time) {
	var pageSize = webcontroller.Configs.PageSize;
	webcontroller.SendToServer('I${domainName}Svc', 'qry${domainName}ListPaged', [ {
		"name" : "pgnum",
		"type" : "int",
		"value" : pageNumber
	}, {
		"name" : "pgsize",
		"type" : "int",
		"value" : pageSize
	} ], function(oresp, oreq) {
		$("#${domainName}DataGrid").datagrid("clearSelections");
		/ 这里是加载json格式的字符串，
		$("#${domainName}DataGrid").datagrid("loadData",
				webcontroller.GetBindEasyUIJSON(oresp.resultSet));

	}, function(oresp, oreq) {
		$.messager.alert("提示", "查询失败！", 'info');
	});
};

// 卸载
${domainName}.Unload = function() {

};

$(function() {
	webcontroller.FocusObject = ${domainName};
	${domainName}.Initialization();
});

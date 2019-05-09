var ${domainName} = new Object;

${domainName}.RowJson = {
<#list list as map>"${map.COLUMN_NAME}":null<#if map_has_next>,</#if> </#list>
};
// ��ʼ��
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
			'${tableComment}�б�', columns);

};

 // ����DataGrid��ҳ�ؼ�
${domainName}.InitializationPagination = function() {
	var p = $('#${domainName}DataGrid').datagrid('getPager');
	$(p).pagination({
		pageNumber : 1,
		pageSize : webcontroller.Configs.PageSize,
		showPageList : false,
		onRefresh : function(pageNumber, pageSize) {
			// ˢ��
			${domainName}.LoadDataGridData(pageNumber);
		},
		onSelectPage : function(pageNumber, pageSize) {
			// ��ҳ
			${domainName}.LoadDataGridData(pageNumber);
		}
	});
};

// ��ʼ��DataGrid������
${domainName}.InitializationToolbar = function() {
	webcontroller.BindDatagridToolbarItemSearch(
			$('#${domainName}DataGrid'), webcontroller.User.DefaultPageID);
};

//  ���
${domainName}.NewDialog = function() {

	var btns = [];
	btns[btns.length] = {
		text : '����',
		iconCls : 'icon-ok',
		handler : function() {
			${domainName}.OnAddEvent();
		}
	};
	btns[btns.length] = {
		text : 'ȡ��',
		iconCls : 'icon-cancel',
		handler : function() {
			$('#WepAppAllDialog').dialog('close');
		}
	};

	webcontroller.WepAppAllDialog('���', 450, 350,
			'${domainName}_Form.html', btns, function() {
				$('#Form${domainName}').form('clear');
			//	${domainName}.InitFormPage.BindWQByCode($('#wqa'),'ShuiZhiLeiBie');
			//	${domainName}.InitFormPage.BindWQByCode($('#wqk'),'ShuiZhiLeiBie');
			//	${domainName}.InitFormPage.BindWQByCode($('#ns'),'YingYangZhuangTai');
				
			});
};

// �޸�
${domainName}.EditDialog = function() {
	// ��������ѡ�е��У���û��ѡ�еļ�¼ʱ�������ؿ����顣
	var selectRows = $('#${domainName}DataGrid').datagrid('getSelections');
	if (selectRows.length > 1) {

		$.messager.alert('��ʾ', '�޸�ʱֻ��ѡ���У�������ѡ������ѡ�� ' + selectRows.length
				+ ' �У�', 'info');


		return;
	}
	var row = $('#${domainName}DataGrid').datagrid('getSelected');
	if (row) {
		var btns = [];
		btns[btns.length] = {
			text : '����',
			iconCls : 'icon-ok',
			handler : function() {
				${domainName}.OnModifyEvent();
			}
		};
		btns[btns.length] = {
			text : 'ȡ��',
			iconCls : 'icon-cancel',
			handler : function() {
				$('#WepAppAllDialog').dialog('close');
			}
		};

		webcontroller.WepAppAllDialog('�޸�', 450, 350,
				'${domainName}_Form.html', btns, function() {
					$('#Form${domainName}').form('clear');
					$('#Form${domainName}').form('load', row);
				//	${domainName}.InitFormPage.BindWQByCode($('#wqa'),'ShuiZhiLeiBie',row.wqa);
				//	${domainName}.InitFormPage.BindWQByCode($('#wqk'),'ShuiZhiLeiBie',row.wqk);
				//	${domainName}.InitFormPage.BindWQByCode($('#ns'),'YingYangZhuangTai',row.ns);
					
				});
	} else {
		$.messager.alert('��ʾ', '��ѡ��Ҫ �޸� �����У�', 'info');
	}
};
/ ��ʼ��Formҳ��ؼ�
${domainName}.InitFormPage = {
		BindFName : function(addvcd) {
			// ������
			webcontroller.BindWrAddvByFid($('#addvcd'), webcontroller.User.ADDVCD,
					addvcd);

		}
};

// �鿴
${domainName}.ViewDialog = function() {
	var row = $('#${domainName}DataGrid').datagrid('getSelected');
	if (row) {
		var btns = [];
		btns[btns.length] = {
			text : 'ȡ��',
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
		$.messager.alert('��ʾ', '��ѡ��Ҫ �鿴 �����У�', 'info');
	}
};

// ɾ��
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
		var confirmMsg =  '��ȷ��Ҫɾ���⡾' + rows.length + '����������';
		$.messager.confirm('��Ϣ', confirmMsg, function(r) {
			if (r) {
				webcontroller.SendToServer('I${domainName}Svc', 'del${domainName}', [ {
					"type" : "string",
					"name" : "ids",
					"value" : ids
				} ], function(oresp, oreq) {
					${domainName}.LoadDataGridData(1);
					webcontroller.MessageShow('ɾ���ɹ���');
				}, function(oresp, oreq) {
					$.messager.alert("��ʾ", "ɾ��ʧ�ܣ�", 'info');
				});
			}
		});
	} else {
		$.messager.alert('��ʾ', '��ѡ��Ҫ ɾ�� �����У�', 'info');
	}
};
// 添加
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
			webcontroller.CloseDialog('����ɹ���');
			// ���ص��ǵ�ǰҳ�ļ�¼���ǵ�һҳ
			${domainName}.LoadDataGridData(1);
		}, function(oresp, oreq) {
			$.messager.alert("��ʾ", oresp.RespHeader.ErrorMsg, 'info');
		});
	} else {
		$.messager.alert("��ʾ", "��֤δͨ����", 'info');
	}
};

// �޸�
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
			webcontroller.CloseDialog('����ɹ���');
			${domainName}.LoadDataGridData(1);
		}, function(oresp, oreq) {
			$.messager.alert("��ʾ", oresp.RespHeader.ErrorMsg, 'info');
		});
		${domainName}.RowJson.id=null;
	} else {
		$.messager.alert("��ʾ", "��֤δͨ����", "info");
	}
};

${domainName}.LoadDataGridData = function(pageNumber) {
	${domainName}.LoadData(pageNumber, "");
};
// ��ѯ
${domainName}.search = function() {
	var time1 = "";
	${domainName}.LoadData(1, time1);
};

// ��������
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
		/ �����Ǽ���json��ʽ���ַ�����
		$("#${domainName}DataGrid").datagrid("loadData",
				webcontroller.GetBindEasyUIJSON(oresp.resultSet));

	}, function(oresp, oreq) {
		$.messager.alert("��ʾ", "��ѯʧ�ܣ�", 'info');
	});
};

// ж��
${domainName}.Unload = function() {

};

$(function() {
	webcontroller.FocusObject = ${domainName};
	${domainName}.Initialization();
});

package com.roch.web.svcinfs;

import com.roch.accinf.MetaInfoAnnotation;
import com.roch.viewmodel.sysmng.DataPagedModel;

/**
 * ${tableComment} 接口
 * 
 *
 */
public interface I${domainName}Svc extends ISvcBase{
	
	/**
	 * 添加${tableComment}信息
	 * 
	 * @param item
	 * @return
	 */
	boolean add${domainName}(${domainName} item);

	/**
	 * 修改${tableComment}信息
	 * 
	 * @param item
	 * @return
	 */
	boolean update${domainName}(${domainName} item);

	/**
	 * 删除${tableComment}信息
	 * 
	 * @param id
	 * @return
	 */
	boolean del${domainName}(String id);

	/**
	 * 查询${tableComment}数据列表 分页
	 * 
	 * @return
	 */
	@MetaInfoAnnotation("[]")
	DataPagedModel<${domainName}Vo> qry${domainName}ListPaged(Integer pageSize, Integer pageNum);

}

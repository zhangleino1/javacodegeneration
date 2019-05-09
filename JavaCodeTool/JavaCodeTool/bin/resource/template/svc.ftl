package com.roch.web.svcinfs;

import com.roch.accinf.MetaInfoAnnotation;
import com.roch.viewmodel.sysmng.DataPagedModel;

/**
 * ${tableComment} �ӿ�
 * 
 *
 */
public interface I${domainName}Svc extends ISvcBase{
	
	/**
	 * ���${tableComment}��Ϣ
	 * 
	 * @param item
	 * @return
	 */
	boolean add${domainName}(${domainName} item);

	/**
	 * �޸�${tableComment}��Ϣ
	 * 
	 * @param item
	 * @return
	 */
	boolean update${domainName}(${domainName} item);

	/**
	 * ɾ��${tableComment}��Ϣ
	 * 
	 * @param id
	 * @return
	 */
	boolean del${domainName}(String id);

	/**
	 * ��ѯ${tableComment}�����б� ��ҳ
	 * 
	 * @return
	 */
	@MetaInfoAnnotation("[]")
	DataPagedModel<${domainName}Vo> qry${domainName}ListPaged(Integer pageSize, Integer pageNum);

}

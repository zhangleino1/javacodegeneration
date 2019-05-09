package com.roch.web.svcs;////---------------------------注意修改路径

import java.util.List;

import com.roch.accinf.Request;
import com.roch.accinf.Response;
import com.roch.utils.JacksonMapper;
import com.roch.utils.hbnt3.HbntGeneralDao;
import com.roch.viewmodel.sysmng.DataPagedModel;
import com.roch.web.svcinfs.ISvcBase;
import com.roch.web.svcs.BaseServiceImpl;
/**
 * ${tableComment} 接口实现类
 * 
 *
 */
public class ${domainName}Impl extends BaseServiceImpl implements I${domainName}Svc{
	HbntGeneralDao<${domainName}, String> sdictDao_m1 = null;

	public HbntGeneralDao<${domainName}, String> getSdictDao_m1() {
		if (sdictDao_m1 == null)
			sdictDao_m1 = new HbntGeneralDao<${domainName}, String>(
					new ${domainName}(), "", this.getSessionFactory());
		return sdictDao_m1;
	}
	@Override
	public Response doRequest(Request oReq) throws Exception {
		Request.Command cmd = oReq.getCommand().get(0);
		if ("add${domainName}".equalsIgnoreCase(cmd.getName())) {
			String itemJson = cmd.getArg("item");
			${domainName} item = JacksonMapper.getInstance().readValue(itemJson, ${domainName}.class);
			this.add${domainName}(item);
			return this.makeTxtMsgResponse(oReq, ISvcBase.ErrorCode_SvcOK, "OK");
		}
		if ("update${domainName}".equalsIgnoreCase(cmd.getName())) {

			String itemJson = cmd.getArg("item");

			${domainName} item = JacksonMapper.getInstance().readValue(itemJson, ${domainName}.class);
			this.update${domainName}(item);
			return this.makeTxtMsgResponse(oReq, ISvcBase.ErrorCode_SvcOK, "OK");
		}
		if ("del${domainName}".equalsIgnoreCase(cmd.getName())) {

			String ids = cmd.getArg("ids");
			this.del${domainName}(ids);
			return this.makeTxtMsgResponse(oReq, ISvcBase.ErrorCode_SvcOK, "OK");
		}

		if ("qry${domainName}ListPaged".equalsIgnoreCase(cmd.getName())) {
			Integer pageSize = Integer.valueOf(cmd.getArg("pgsize"));
			Integer pageNumber = Integer.valueOf(cmd.getArg("pgnum"));
			if (pageSize == 0) {
				pageSize = 15;
			}
			if (pageNumber == 0) {
				pageNumber = 1;
			}
			DataPagedModel<${domainName}Vo> pagedModel = this.qry${domainName}ListPaged(pageSize, 
					pageNumber,  projectName,addvcd);
			return this.makePagedJsonMsgResponse(oReq, ISvcBase.ErrorCode_SvcOK, "OK", pagedModel);
		}
		return null;
	}

	@Override
	public boolean add${domainName}(${domainName} item) {
		// TODO Auto-generated method stub
		this.getSdictDao_m1().save(item);
		return true;
	}

	@Override
	public boolean update${domainName}(${domainName} item) {
		// TODO Auto-generated method stub
		this.getSdictDao_m1().update(item);
		return true;
	}

	@Override
	public boolean del${domainName}(String id) {
		// TODO Auto-generated method stub
		String hql = String.format(
				" from  ${domainName} where id in (%s)", id);
		List<${domainName}> list=this.getSdictDao_m1().find(hql);
		this.getSdictDao_m1().deleteAll(list);
		return false;
	}

	@Override
	public DataPagedModel<${domainName}Vo> qry${domainName}ListPaged(Integer pageSize,Integer pageNum) {
		String hql = "select new com.roch.viewmodel.${domainName}Vo"//--------------------------注意修改路径
				+ " (<#list list as map>a.${map.COLUMN_NAME}<#if map_has_next>,</#if> </#list>) "
				+ " from ${domainName} a";
	/*	if(!("").equals(addvcd)){
			hql += String.format(" and b.addvcd = '%s' ", addvcd);
		} */
		DataPagedModel<${domainName}Vo> pagedModel = new DataPagedModel<${domainName}Vo>();
		pagedModel.setPageSize(pageSize);
		pagedModel.setCurrentPage(pageNum);
		pagedModel.setQryHql(hql);
		try {
			this.getSdictDao_m1().hqlPagedQuerry(pagedModel);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return pagedModel;
	}

}

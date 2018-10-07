package com.sjz.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by highness on 2018/3/9 0009.
 */
public interface BaseDao<E> {
    /**mybatis-generator:generate begin***/
    E selectByPrimaryKey(Long id);

    int deleteByPrimaryKey(Long id);

    int insert(E entity);

    int insertSelective(E entity);

    int updateByPrimaryKeySelective(E entity);

    int updateByPrimaryKey(E entity);
    /**mybatis-generator:generate end***/

    /**extended definition begin***/
    int insertBatch(List<E> entityList);

    int deleteBatchByPrimaryKey(@Param("search") Object search);

    int updateByParamsSelective(@Param("entity") E entity, @Param("search") Object search);

    int countByParams(@Param("search") Object search);

    List<Long> selectForPrimaryKey(@Param("search") Object search);

    List<E> selectByParams(@Param("search") Object search);
    /**extended definition end***/
}
